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
    item.at("//content:encoded").inner_html.from(9).to(-4)
  end
  
  def mp3_from(item)
    item.at("//enclosure").attributes["url"]
  end
end

# ex = XFruitsPostExtractor.new
# posts = ex.extract_from(File.join(File.dirname(__FILE__), "..", "x-fruits-feed-example.rss"))
# p posts.size
# p posts.first.title
# p posts.first.body
# p posts.first.mp3
