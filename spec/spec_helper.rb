require 'pronounce'
require 'phone'
require 'syllable'
require 'syllabification_context'
require 'syllable_rules/sonority_sequencing_principle'

def make_phones(*phones)
  phones.map {|phone| Pronounce::Phone.create phone }
end

def make_syllable(*phones)
  Pronounce::Syllable.new(make_phones(*phones))
end
