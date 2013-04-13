module Pronounce::SyllableRules::English
  # Stressed syllables cannot be light.
  class StressedSyllablesHeavy
    def self.evaluate(context)
      pending_syllable = context.pending_syllable
      false if pending_syllable.stressed? && pending_syllable.light?
    end

  end
end
