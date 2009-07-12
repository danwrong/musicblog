require 'text_converter.rb'

class DialectizerTextConverter < TextConverter
  class Rule
    attr_accessor :regex, :replacement
    
    def initialize(regex, replacement)
      self.regex = regex
      self.replacement = replacement
    end
  end
  
  def self.rules
    @rules ||= []
  end
  
  def self.replace(regex, with)
    with = with[:with] if with.is_a?(Hash)
    rules << Rule.new(regex, with)
  end
  
  def convert_snippet(string)
    returning result = string.dup do
      self.class.rules.each do |rule|
        result.gsub!(rule.regex, rule.replacement)
      end
    end
  end
end