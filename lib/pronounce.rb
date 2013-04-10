require 'phone'
require 'syllabification_context'
require 'syllable'
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
        dictionary[word.downcase] = pron.map {|syllable| syllable.as_strings }
      end

      dictionary
    end

    def split_syllables(word)
      syllables = []
      pending_phones = []
      word.each_with_index do |phone, i|
        if new_syllable? SyllabificationContext.new(syllables, word, i)
          syllables << Syllable.new(pending_phones)
          pending_phones = []
        end
        pending_phones << phone
      end
      syllables << Syllable.new(pending_phones)
    end

    def new_syllable?(context)
      return false if context.word_beginning?

      SyllableRules::SonoritySequencingPrinciple.evaluate(context)
    end

  end
end
