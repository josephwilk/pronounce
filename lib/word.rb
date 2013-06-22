require 'phone'
require 'syllabification_context'
require 'syllable'
require 'syllable_rules'

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
      SyllableRules.evaluate context
    end

  end
end
