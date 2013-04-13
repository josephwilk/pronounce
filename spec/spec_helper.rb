require 'phone'
require 'syllable'

def make_phones(*phones)
  phones.map {|phone| Pronounce::Phone.create phone }
end

def make_syllable(*phones)
  Pronounce::Syllable.new(make_phones(*phones))
end
