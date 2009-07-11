class Post
  attr_accessor :title, :body, :mp3
  
  def initialize(title, body, mp3)
    @title = title
    @body = body
    @mp3 = mp3
  end
end