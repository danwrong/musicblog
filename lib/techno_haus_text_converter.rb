require 'dialectizer_text_converter'

class TechnoHausTextConverter < DialectizerTextConverter
  replace 'the ', :with => 'de '
  replace 'house', :with => 'haus'
  
  exclaim 'Get down with de style!'
  exclaim 'Get ready for zis!'
  exclaim "No no limits, we'll reach for the sky!"
  exclaim "Hard to the core, I feel the floor"
  exclaim "No valley too deep, no mountain too high"
  exclaim "No no limits, won't give up the fight"
  exclaim "I'm playing on the road; I've got no fear"
  exclaim "I'll put you down in a microphone contest"
  exclaim "Bass in your face, the electric bomb"
  exclaim "Throw the groove down"
  exclaim "We race them, we gotta pump, we can't can't get loose"
  exclaim "I want you to turn on the groove"
  exclaim "It drives you away just like a fast car"
end

p TechnoHausTextConverter.new.convert_snippet('Tom Ward in the house!')