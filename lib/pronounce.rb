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

    WORD_PRONUNCIATION_DELIMITER = '  '

    def pronunciations
      @pronunciations ||= build_pronunciation_dictionary
    end

    def build_pronunciation_dictionary
      DataReader.pronunciations.each_with_object({}) { |line, dictionary|
        if valid_word?(line)
          word, raw_phones = line.split(WORD_PRONUNCIATION_DELIMITER)
          word.downcase!
          dictionary[word.freeze] = Word.new(raw_phones)
        end
      }
    end

    def valid_word?(line)
      /\A[A-Z]+  /.match?(line)
    end
  end
end
