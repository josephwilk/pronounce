require 'word'

module Pronounce
  CMUDICT_VERSION = '0.7a'
  DATA_DIR = File.dirname(__FILE__) + '/../data'

  class << self
    def how_do_i_pronounce(word)
      @pronouncations ||= build_pronuciation_dictionary
      word = word.downcase
      if @pronouncations[word]
        @pronouncations[word].syllables.map {|syllable| syllable.to_strings }
      end
    end

    def symbols
      @symbols ||= File.read("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.symbols").
                        split("\r\n")
    end

    private

    def build_pronuciation_dictionary
      dictionary = {}

      File.readlines("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}").each do |line|
        word, *raw_phones = line.strip.split
        next unless word && !word.empty? && !word[/[^A-Z]+/]
        dictionary[word.downcase] = Word.new raw_phones
      end

      dictionary
    end

  end
end
