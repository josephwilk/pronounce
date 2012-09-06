module Words
  CMUDICT_VERSION = '0.7a'
  DATA_DIR = File.dirname(__FILE__) + '/../data'

  class << self
    def how_do_i_pronounce(word)
      @pronouncation_dictionary ||= build_pronuciation_dictionary
      @pronouncation_dictionary[word.downcase]
    end

    private
  
    def build_pronuciation_dictionary
      dictionary = {}
    
      File.open("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}") do |f|
        f.readlines.each do |line|
          word, *pron = line.strip.split(' ')
          next unless word && !word.empty? && !word[/[^A-Z]+/]
          dictionary[word.downcase] = pron
        end
      end
      
      dictionary
    end

  end
end