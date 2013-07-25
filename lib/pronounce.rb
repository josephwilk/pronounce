require 'data_reader'
require 'word'

module Pronounce
  class << self
    def how_do_i_pronounce(word)
      @pronouncations ||= build_pronuciation_dictionary
      word.downcase!
      if @pronouncations.has_key? word
        @pronouncations[word].syllables.map {|syllable| syllable.to_strings }
      end
    end

    def symbols
      @symbols ||= DataReader.symbols.map &:strip
    end

    private

    def build_pronuciation_dictionary
      DataReader.pronunciations.each_with_object({}) do |line, dictionary|
        word, *raw_phones = line.strip.split
        next unless word && !word.empty? && !word[/[^A-Z]+/]
        dictionary[word.downcase] = Word.new raw_phones
      end
    end

  end
end
