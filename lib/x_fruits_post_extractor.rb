require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'activesupport'
require 'post'
require 'fileutils'
require 'digest/md5'

class XFruitsPostExtractor
  def extract_from(url_or_file)
    doc = Hpricot.XML(open(url_or_file))
    items = doc.search("//item")

    items = items.select do |item|
      item.at("//content:encoded")
    end
    
    # Only choose items with a single mp3 link
    
    items = items.select do |item|
      candidates = Hpricot(body_from(item)).search("//a").select {|x| x.attributes["href"].ends_with?(".mp3")}
      candidates.size == 1
    end
    
    items.collect do |item|
      Post.new(title_from(item), body_from(item), mp3_from(item)) rescue nil
    end.compact
  end
  
  def title_from(item)
    item.at("//title").inner_html
  end
  
  def body_from(item)
    doc = Hpricot(item.at("//content:encoded").inner_text)
    doc.search("//a").each do |item|
      doc.search("//a[@href='#{item.attributes["href"]}']").remove if item.attributes["href"].starts_with?("http://feeds.word")
    end
    
    doc.search("//object").remove
    
    doc.search("//img").each do |item|
      doc.search("//img[@src='#{item.attributes["src"]}']").remove if item.attributes["src"].starts_with?("http://stats.word")
    end
    
    doc.to_html
  end
  
  def mp3_from(item)
    link = Hpricot(body_from(item)).search("//a").detect {|x| x.attributes["href"].ends_with?(".mp3")}
    result = link.attributes["href"]
    if result =~ / /
      URI.encode(result)
    else
      result
    end
    digest = Digest::MD5.hexdigest(result)
    FileUtils.mkdir_p(File.join(File.dirname(__FILE__), "..", "tmp"))
    path = File.expand_path(File.join(File.dirname(__FILE__), "..", "tmp", digest + ".mp3"))
    unless File.exist?(path)
      `curl \"#{result}\" > #{path}`
    end
    if File.size(path) > 1000000
      path
    else
      raise "MP3 could not be downloaded"
    end
  end
end
# 
# ex = XFruitsPostExtractor.new
# posts = ex.extract_from("http://www.xfruits.com/danwrong/?id=71469")
# 
# posts.each do |post|
# #  p post.title
#   p post.mp3
# #  p post.body
# end
# 
# posts = ex.extract_from(File.join(File.dirname(__FILE__), "..", "x-fruits-feed-example.rss"))
# p posts.size
# p posts.first.title
# p posts.first.body
# p posts.first.mp3
