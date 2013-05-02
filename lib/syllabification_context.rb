require 'syllable'

module Pronounce
  class SyllabificationContext
    def initialize(completed_syllables, phones, phone_index)
      @completed_syllables = completed_syllables
      @phones = phones
      @phone_index = phone_index
    end

    def current_phone
      @phones[@phone_index]
    end

    def next_phone
      @phones[@phone_index + 1] unless word_end?
    end

    def previous_phone
      @phones[@phone_index - 1] unless word_beginning?
    end

    def pending_syllable
      Syllable.new(@phones.slice(completed_length...@phone_index))
    end

    def word_beginning?
      @phone_index == 0
    end

    def word_end?
      @phone_index == @phones.length - 1
    end

    private

    def completed_length
      @completed_syllables.map(&:length).reduce(0, :+)
    end

  end
end
