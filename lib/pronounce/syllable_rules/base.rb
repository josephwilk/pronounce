module Pronounce::SyllableRules
  # Breaks syllables at the low point of sonority between vowels.
  rule :base, 'Sonority Sequencing Principle' do
    return :new_syllable if current_phone.syllabic? && !previous_phone_in_onset?
    return :no_new_syllable if word_end?
    (previous_phone_in_coda? || sonority_trough?) ? :new_syllable : :no_new_syllable
  end

end
