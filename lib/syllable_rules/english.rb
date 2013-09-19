module Pronounce::SyllableRules
  rule :en, '/ng/ cannot start a syllable' do |context|
    false if context.current_phone.eql? ::Pronounce::Phone.new 'NG'
  end

  # http://en.wikipedia.org/wiki/Syllable_weight#Linguistics
  rule :en, 'stressed syllables cannot be light' do |context|
    false if context.pending_syllable.stressed? && context.pending_syllable.light?
  end

  # Triplet onsets must start with /s/, followed by a voiceless stop or
  # fricative, and end with an approximant.
  rule :en, 'triplet onsets' do |context|
    false if context.previous_phone.eql?(::Pronounce::Phone.new('S')) &&
      !context.previous_phone_in_coda? &&
      !context.current_phone.voiced? &&
      context.current_phone.articulation?(:stop, :fricative) &&
      context.next_phone.approximant?
  end

end
