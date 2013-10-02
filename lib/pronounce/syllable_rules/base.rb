module Pronounce::SyllableRules
  # Breaks syllables at the low point of sonority between vowels.
  rule :base, 'Sonority Sequencing Principle' do
    return true if current_phone.syllabic? && !previous_phone_in_onset?
    return false if word_end?
    previous_phone_in_coda? || sonority_trough?
  end

end
