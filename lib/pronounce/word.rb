require 'pronounce/phone'
require 'pronounce/syllabification_context'
require 'pronounce/syllable'
require 'pronounce/syllable_rules'
require 'pronounce/syllable_rules/base'
require 'pronounce/syllable_rules/english'

module Pronounce
  class Word
    def initialize(raw_phones)
      @raw_phones = raw_phones
    end

    def pronunciation
      syllables.map(&:to_strings)
    end

    private

    attr_reader :raw_phones

    def syllables
      @syllables ||= split_syllables
    end

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

    def phones
      @phones ||= raw_phones.split.map { |symbol| Phone.new(symbol) }
    end

    def new_syllable?(context)
      return false if context.word_beginning?
      SyllableRules.evaluate(context) == :new_syllable
    end
  end
end
