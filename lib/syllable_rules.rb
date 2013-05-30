module Pronounce::SyllableRules
  def self.evaluate(context)
    [:stressed_syllables_heavy, :disallow_ng_onset].each do |rule|
      is_new_syllable = English.send rule, context
      return is_new_syllable unless is_new_syllable.nil?
    end
    sonority_sequencing_principle context
  end

  # Breaks syllables at the low point of sonority between vowels.
  def self.sonority_sequencing_principle(context)
    return true if context.current_phone.syllabic? && !context.previous_phone_in_onset?
    return false if context.word_end?
    (context.current_phone < context.next_phone && context.current_phone <= context.previous_phone) || context.previous_phone_in_coda?
  end

end
