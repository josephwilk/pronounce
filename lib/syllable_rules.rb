module Pronounce::SyllableRules
  class << self
    def evaluate(context)
      rules[:en].each do |rule|
        is_new_syllable = English.send rule, context
        return is_new_syllable unless is_new_syllable.nil?
      end
      send rules[:base], context
    end

    def rule(name, &block)
      rules[name] = block
    end

    def [](name)
      rules[name]
    end

    private

    def rules
      @rules ||= {
        en: [:stressed_syllables_heavy, :disallow_ng_onset],
        base: :sonority_sequencing_principle
      }
    end

  end

  # Breaks syllables at the low point of sonority between vowels.
  def self.sonority_sequencing_principle(context)
    return true if context.current_phone.syllabic? && !context.previous_phone_in_onset?
    return false if context.word_end?
    context.previous_phone_in_coda? || context.sonority_trough?
  end

end
