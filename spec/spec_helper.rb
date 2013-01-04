require 'pronounce'
require 'phone'
require 'syllabification_context'
require 'syllable_rules/sonority_sequencing_principle'

def build_word(*phones)
  phones.map {|phone| ::Pronounce::Phone.create phone }
end
