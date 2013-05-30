module Pronounce::SyllableRules
  # Breaks syllables at the low point of sonority between vowels.
  def self.sonority_sequencing_principle(context)
    return true if context.current_phone.syllabic? && !context.previous_phone_in_onset?
    return false if context.word_end?
    (context.current_phone < context.next_phone && context.current_phone <= context.previous_phone) || context.previous_phone_in_coda?
  end

end
