require 'rubygems'
require 'httparty'
require 'multipart/post'
require 'post'
require 'open-uri'

class TumblrExporter
  include HTTParty
  
  GENERATOR = 'Music Hack Day Thingy'
  
  def initialize(email, password)
    @email, @password = email, password
  end
  
  def export(posts)
    posts.each do |p|
      post_audio(p)
    end
  end
  
  def post_audio(item)
    multipart = Multipart::Post.new({
      'email' => @email,
      'password' => @password,
      'generator' => GENERATOR,
      'type' => 'audio',
      'data' => open(item.mp3),
      'caption' => "<h2>#{item.title}</h2>#{item.body}"
    })
    
    self.class.post 'http://www.tumblr.com/api/write', 
                    :headers => multipart.headers, :body => multipart.body
  end
  
end