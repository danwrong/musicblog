# Takes a post, and converts the text and audio to be published to a blog

class Persona
  def initialize(text_converter = TextConverter.new, audio_converter = AudioConverter.new)
    @text_converter = text_converter
    @audio_converter = audio_converter
  end
  
  def rewrite(post)
    title, body = @text_converter.convert(post.title, post.body)
    mp3 = @audio_converter.convert(post.mp3)
    Post.new(title, body, mp3)
  end
end