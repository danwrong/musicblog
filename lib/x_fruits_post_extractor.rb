require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'activesupport'
require 'post'

class XFruitsPostExtractor
  def extract_from(url_or_file)
    doc = Hpricot.XML(open(url_or_file))
    items = doc.search("//item")
    
    # Only choose items with a single enclosure, for simplicities sake
    items = items.select do |item|
      item.search("//enclosure").size == 1
    end
    
    # Only choose items with a single mp3 link
    
    items = items.select do |item|
      candidates = Hpricot(body_from(item)).search("//a").select {|x| x.attributes["href"].ends_with?(".mp3")}
      candidates.size == 1
    end
    
    items.collect do |item|
      Post.new(title_from(item), body_from(item), mp3_from(item))
    end
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
    item.at("//enclosure").attributes["url"]
  end
end

# ex = XFruitsPostExtractor.new
# posts = ex.extract_from("http://www.xfruits.com/danwrong/?id=71469&amp%3bclic=393346697&amp%3burl=http%253A%252F%252Ftympanogram.wordpress.com%252F2009%252F07%252F01%252Fmp3-smorgasbord-21%252F")
# 
# posts.each do |post|
#   p post.title
#   p post.mp3
#   p post.body
# end
# 
# posts = ex.extract_from(File.join(File.dirname(__FILE__), "..", "x-fruits-feed-example.rss"))
# p posts.size
# p posts.first.title
# p posts.first.body
# p posts.first.mp3
