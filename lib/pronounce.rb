require 'phone'
require 'syllabification_context'
require 'syllable_rules/sonority_sequencing_principle'

module Pronounce
  CMUDICT_VERSION = '0.7a'
  DATA_DIR = File.dirname(__FILE__) + '/../data'

  class << self
    def how_do_i_pronounce(word)
      @pronouncation_dictionary ||= build_pronuciation_dictionary
      @pronouncation_dictionary[word.downcase]
    end

    def symbols
      @symbols ||= File.read("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.symbols").
                        split("\r\n")
    end

    private

    def build_pronuciation_dictionary
      dictionary = {}

      File.readlines("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}").each do |line|
        word, *pron = line.strip.split(' ')
        next unless word && !word.empty? && !word[/[^A-Z]+/]
        pron = split_syllables(pron.map{|symbol| Phone.create symbol })
        dictionary[word.downcase] = pron.map do |syllable|
          syllable.map {|phone| phone.to_s }
        end
      end

      dictionary
    end

    def split_syllables(word)
      syllables = []
      syllable = []
      word.each_with_index do |phone, i|
        if new_syllable? SyllabificationContext.new(syllables, word, i)
          syllables << syllable
          syllable = []
        end
        syllable << phone
      end
      syllables << syllable
    end

    def new_syllable?(context)
      return false if context.word_beginning?

      SyllableRules::SonoritySequencingPrinciple.evaluate(context)
    end

  end
end
