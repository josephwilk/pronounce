require 'pronounce/data_reader'
require 'pronounce/word'

module Pronounce
  class << self
    def how_do_i_pronounce(word)
      word = word.downcase
      if pronunciations.key?(word)
        pronunciations[word].pronunciation
      end
    end

    private

    def pronunciations
      @pronunciations ||= build_pronunciation_dictionary
    end

    def build_pronunciation_dictionary
      DataReader.pronunciations.each_with_object({}) { |line, dictionary|
        word, *raw_phones = line.split
        dictionary[word.downcase] = Word.new(raw_phones) if valid_word?(word)
      }
    end

    def valid_word?(word)
      !(word.nil? || word.empty? || /[^A-Z]+/.match?(word))
    end
  end
end
