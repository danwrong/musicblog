# From here: http://stackoverflow.com/questions/184178/ruby-how-to-post-a-file-via-http-as-multipart-form-data
require 'mime/types'
require 'uri'


module Multipart
  VERSION = "1.0.0" unless const_defined?(:VERSION)
  
  class Post
    attr_reader :headers, :body
    
    DEFAULT_OPTIONS = {
      :boundary => '0123456789RUBYRUBYRUBYRUBY9876543210',
      :headers  => {}
    }
    
    def initialize(params, options={})
      @options = DEFAULT_OPTIONS.merge(options)
      @params = params
      
      prepare_query
    end
    
    protected
    
    def prepare_query
      parts = @params.collect do |k, v|
        if v.respond_to?(:path) && v.respond_to?(:read)
          FileParam.new(k, v.path, v.read, @options)
        else
          StringParam.new(k, v)
        end
      end
      
      @headers = {
        'Content-Type' => "multipart/form-data; boundary=#{@options[:boundary]}"
      }.merge(@options[:headers])
      
      @body = parts.collect do |part|
        "--#{@options[:boundary]}\r\n#{part.to_multipart}"
      end.join("")
      
      @body << "--#{@options[:boundary]}--"
    end
    
  end

  class StringParam
    attr_accessor :k, :v

    def initialize(k, v)
      @k = k
      @v = v
    end

    def to_multipart
      return "Content-Disposition: form-data; name=\"#{URI::encode(k)}\"\r\n\r\n#{v}\r\n"
    end
  end

  class FileParam
    attr_accessor :k, :filename, :content

    def initialize(k, filename, content, options)
      @k = k
      @filename = filename
      @content = content
      @options = options
    end

    def to_multipart
      mime_type = @options[:mimetype] || (MIME::Types.type_for(filename)[0] || MIME::Types["application/octet-stream"][0])
      mime_type = mime_type.simplified if mime_type.respond_to?(:simplified)
      return "Content-Disposition: form-data; name=\"#{URI::encode(k)}\"; filename=\"#{ @options[:filename] || filename }\"\r\n" +
             "Content-Type: #{ mime_type }\r\n\r\n#{ content }\r\n"
    end
  end
end