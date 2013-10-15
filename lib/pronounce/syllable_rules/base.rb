module Pronounce::SyllableRules
  # Breaks syllables at the low point of sonority between vowels.
  rule :base, 'Sonority Sequencing Principle' do
    verbatim do |context|
      return true if context.current_phone.syllabic? && !context.previous_phone_in_onset?
      return false if context.word_end?
      context.previous_phone_in_coda? || context.sonority_trough?
    end
  end

end
