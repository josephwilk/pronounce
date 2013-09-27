module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do
    false if current_phone.eql? ::Pronounce::Phone.new 'NG'
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do
    false if pending_syllable.stressed? && pending_syllable.light?
  end

end
