require 'data_reader'
require 'word'

module Pronounce
  class << self
    def how_do_i_pronounce(word)
      word.downcase!
      if pronunciations.has_key? word
        pronunciations[word].syllables.map &:to_strings
      end
    end

    def symbols
      @symbols ||= DataReader.symbols.map &:strip
    end

    private

    def pronunciations
      @pronunciations ||= build_pronunciation_dictionary
    end

    def build_pronunciation_dictionary
      DataReader.pronunciations.each_with_object({}) {|line, dictionary|
        word, *raw_phones = line.strip.split
        next unless word && !word.empty? && !word[/[^A-Z]+/]
        dictionary[word.downcase] = Word.new raw_phones
      }
    end

  end
end
