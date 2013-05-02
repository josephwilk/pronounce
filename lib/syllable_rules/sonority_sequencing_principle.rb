module Pronounce::SyllableRules
  # Breaks syllables at the low point of sonority between vowels.
  class SonoritySequencingPrinciple
    def self.evaluate(context)
      return true if context.current_phone.syllabic? && (context.current_phone == context.previous_phone || context.pending_syllable.coda_contains?(context.previous_phone))
      return false if context.word_end?
      (context.current_phone < context.next_phone && context.current_phone <= context.previous_phone) || context.pending_syllable.coda_contains?(context.previous_phone)
    end

  end
end
