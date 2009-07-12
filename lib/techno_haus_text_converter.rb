require 'dialectizer_text_converter'

class TechnoHausTextConverter < DialectizerTextConverter
  replace 'the ',  :with => 'de '
  replace 'house', :with => 'haus'
  replace ' and ', :with => 'und'
  replace 'I ',    :with => 'ich '
  replace ' this', :with => ' zis'
  replace 'good ', :with => 'banging '
  replace ' is ',  :with => ' ist '
  replace ' tune ', :with => ' banging remix tune '
  replace ' track ', :with => ' hardcore minimal euro-trance remix '
  replace ' song ', :with => ' cut '
  
  exclaim 'GET DOWN WITH THE STYLE!'
  exclaim 'Get ready for zis!'
  exclaim "No no limits, we'll reach for the sky!"
  exclaim "HARD TO THE CORE I FEEL THE FLOOR!"
  exclaim "NO VALLEY TOO DEEP, NO MOUNTAIN TOO HIGH!"
  exclaim "NO NO LIMITS WONT GIVE UP THE FIGHT!"
  exclaim "I'm playing on the road; I've got no fear"
  exclaim "I'LL PUT YOU DOWN IN A MICROPHONE CONTEST"
  exclaim "BASS IN YOU FACE, THE ELECTRIC BOMB!"
  exclaim "THROW THE GROOVE DOWN!"
  exclaim "We race them, we gotta pump, we can't can't get loose"
  exclaim "I WANT YOU TO TURN ON THE GROOVE"
  exclaim "It drives you away just like a fast car"
end