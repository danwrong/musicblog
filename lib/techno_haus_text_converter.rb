require 'dialectizer_text_converter'

class TechnoHausTextConverter < DialectizerTextConverter
  replace 'the ',  :with => 'ze '
  replace 'house', :with => 'haus'
  replace ' and ', :with => ' und '
  replace 'I ',    :with => 'ich '
  replace ' this', :with => ' zis'
  replace 'good ', :with => 'GUT '
  replace ' is ',  :with => ' ist '
  replace ' tune ', :with => ' TUNEZ '
  replace ' track ', :with => ' HARDCORE MINIMAL EURO-TRANCE REMIX '
  replace ' song ', :with => ' cut '
  replace ' band ', :with => ' posse and krew '
  replace ' album ', :with => ' DANZEN PARTY MIX!!! '
  replace ' music ', :with => ' TUNEZ '
  replace ' sing', :with => ' MC'
  replace ' melody ', :with => ' SLAMMING BEATZ '
  
  
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