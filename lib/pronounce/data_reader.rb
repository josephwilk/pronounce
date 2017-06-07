module Pronounce
  class DataReader
    CMUDICT_VERSION = '0.7a'
    DATA_DIR = File.dirname(__FILE__) + '/../../data'

    class << self
      def articulations
        dictionary_to_hash("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones")
      end

      def phonations
        dictionary_to_hash("#{DATA_DIR}/cmudict.#{CMUDICT_VERSION}.phonations")
      end

      def pronunciations
        File.foreach("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}")
      end

      private

      DICTIONARY_DELIMITER = "\t"

      def dictionary_to_hash(file_name)
        File.foreach(file_name).map { |line| line.chomp.split(DICTIONARY_DELIMITER) }.to_h
      end
    end
  end
end
