module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do |context|
    false if ::Pronounce::NG === context.current_phone
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do |context|
    false if context.pending_syllable.stressed? && context.pending_syllable.light?
  end

end
