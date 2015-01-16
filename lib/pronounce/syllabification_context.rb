require 'pronounce/syllable'

module Pronounce
  class SyllabificationContext
    def initialize(completed_syllables, phones, phone_index)
      @completed_syllables = completed_syllables
      @phones = phones
      @phone_index = phone_index
    end

    def current_onset
      return [] if phones[phone_index].syllabic? || next_vowel_index == nil
      phones.slice(valid_syllables_length...next_vowel_index)
    end

    def current_phone
      phones[phone_index]
    end

    def next_phone
      phones.fetch(phone_index + 1, nil)
    end

    def previous_phone
      phones[phone_index - 1] unless word_beginning?
    end

    def pending_syllable
      Syllable.new(phones.slice(completed_length...phone_index))
    end

    def previous_phone_in_coda?
      pending_syllable.coda_contains? previous_phone
    end

    def previous_phone_in_onset?
      !pending_syllable.has_nucleus?
    end

    def sonority_trough?
      current_phone <= previous_phone && current_phone < next_phone
    end

    def word_beginning?
      phone_index == 0
    end

    def word_end?
      phone_index == phones.length - 1
    end

    private

    attr_reader :completed_syllables, :phones, :phone_index

    def completed_length
      completed_syllables.map(&:length).reduce(0, :+)
    end

    def next_vowel_index
      next_vowel = phones.slice(phone_index...phones.length).find(&:syllabic?)
      phones.find_index { |phone| next_vowel.equal? phone }
    end

    def valid_pending_syllable_length
      pending_syllable.has_nucleus? ? pending_syllable.length : 0
    end

    def valid_syllables_length
      completed_length + valid_pending_syllable_length
    end
  end
end
