require 'dialectizer_text_converter'

class ElmerFuddTextConverter < DialectizerTextConverter
  replace /[rl]/, :with => 'w'
  replace /qu/, :with => 'qw'
  replace /th\b/, :with => 'f'
  replace /th/, :with => 'd'
  replace /n[.]/, :with => 'n, uh-hah-hah-hah.'
end
