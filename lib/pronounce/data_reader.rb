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
        File.readlines("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}")
      end

      private

      def dictionary_to_hash(file_name)
        File.readlines(file_name).map { |line| line.chomp.split("\t") }.to_h
      end
    end
  end
end
