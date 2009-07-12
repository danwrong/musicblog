require 'rubygems'
require 'hpricot'
require 'active_support'

class TextConverter
  def convert(title, body)
    title = convert_title(title)
    body = convert_body(body)
    
    return title, body
  end
  
  protected
  
  def convert_title(title)
    convert_snippet(title)
  end
  
  def convert_body(body)
    doc = Hpricot(body)
    
    doc.search('//text()').each do |snippet|
      new_text = convert_snippet(snippet.inner_text)
      snippet.swap(new_text)
    end
    
    doc.to_html
  end
end