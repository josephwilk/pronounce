require 'phone'
require 'syllabification_context'
require 'syllable'
require 'syllable_rules/sonority_sequencing_principle'
require 'syllable_rules/english/disallow_ng'
require 'syllable_rules/english/stressed_syllables_heavy'

module Pronounce
  class Word
    def initialize(raw_phones)
      @phones = raw_phones.map {|symbol| Phone.create symbol }
    end

    def syllables
      @syllables ||= split_syllables
    end

    private

    attr_reader :phones

    def split_syllables
      syllables = []
      pending_phones = []
      phones.each_with_index do |phone, i|
        if new_syllable? SyllabificationContext.new(syllables, phones, i)
          syllables << Syllable.new(pending_phones)
          pending_phones = []
        end
        pending_phones << phone
      end
      syllables << Syllable.new(pending_phones)
    end

    def new_syllable?(context)
      return false if context.word_beginning?

      is_new_syllable = SyllableRules::English::StressedSyllablesHeavy.evaluate(context)
      return is_new_syllable unless is_new_syllable.nil?
      is_new_syllable = SyllableRules::English::DisallowNG.evaluate(context)
      return is_new_syllable unless is_new_syllable.nil?
      SyllableRules::SonoritySequencingPrinciple.evaluate(context)
    end

  end
end
