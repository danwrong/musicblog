require 'uri'
require 'net/http'
require 'multipart/post'
require 'audio_converter'

# http://soundroots.org/Franti-HelloBonjour.mp3

class DonkConverter < AudioConverter
  DONK_URI = 'http://www.donkdj.com/remix'
  
  def convert(filename)
    file = open(filename)
    
    remix_url = upload_file(file)
    
    get_remix_path_when_complete(remix_url)
  end
  
  def upload_file(file)
    multipart = Multipart::Post.new({
      'upload[mp3]' => file,
      'upload[donk_type]' => '-1',
      'upload[pitchshift]' => '1.4',
      'upload[kickdrum]' => '1',
      'upload[snare]' => '1',
      'upload[hihat]' => '1'
    }, :mimetype => 'audio/mpeg', :filename => 'track.mp3')
    
    request = Net::HTTP::Post.new uri.request_uri
    request.body = multipart.body
    request.initialize_http_header multipart.headers
    
    response = http.request(request)
    
    if response.code == '302'
      response['Location'].gsub(/\?(.*)$/, '')
    else
      raise ConversionError, 'failed to upload to donkdj...'
    end
  end
  
  def get_remix_path_when_complete(remix_url)
    remix = URI.parse(remix_url)
    loop do
      request = Net::HTTP::Get.new remix.request_uri
      response = http.request(request)
      
      if response.code == '302'
        request = Net::HTTP::Get.new response['Location']
        response = http.request(request)
      end
      
      if response.code == '200'
        case response.body
        when /There was a problem remixing this song./
          raise ConversionError, 'donkdj could not donkify this track'
        when /var mp3path\='([^']+)'/
          return $1
        when /Please wait/
          nil
        else
          raise ConversionError, 'donkdj has fail'
        end
      else
        raise ConversionError, "donkdj returned #{response.code}"
      end
      
      sleep 10
    end
  end
  
  protected
  
  def uri
     URI.parse(DONK_URI)
   end
  
  def http
    Net::HTTP.new(uri.host, uri.port)
  end
end