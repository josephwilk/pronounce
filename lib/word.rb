require 'phone'
require 'syllabification_context'
require 'syllable'
require 'syllable_rules'
require 'syllable_rules/english'

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

      is_new_syllable = SyllableRules::English.stressed_syllables_heavy context
      return is_new_syllable unless is_new_syllable.nil?
      is_new_syllable = SyllableRules::English.disallow_ng_onset context
      return is_new_syllable unless is_new_syllable.nil?
      SyllableRules.sonority_sequencing_principle context
    end

  end
end
