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
  
  def self.exclamations
    @exclamations ||= []
  end
  
  def self.replace(regex, with)
    with = with[:with] if with.is_a?(Hash)
    rules << Rule.new(regex, with)
  end
  
  def self.exclaim(string)
    self.exclamations << string
  end
  
  def convert_snippet(string)
    result = string.dup
    self.class.rules.each do |rule|
      result.gsub!(rule.regex, rule.replacement)
    end
    result = result.split(". ").collect do |sentence|
      if rand(1) == 0 && !self.class.exclamations.empty?
        "#{sentence}. #{self.class.exclamations.rand}"
      else
        sentence
      end
    end.join(". ")
    result
  end
end