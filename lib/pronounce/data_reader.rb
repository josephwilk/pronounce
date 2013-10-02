module Pronounce
  class DataReader
    CMUDICT_VERSION = '0.7a'
    DATA_DIR = File.dirname(__FILE__) + '/../../data'

    class << self
      def articulations
        File.readlines "#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones"
      end

      def phonations
        File.readlines "#{DATA_DIR}/cmudict.#{CMUDICT_VERSION}.phonations"
      end

      def pronunciations
        File.readlines "#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}"
      end
    end

  end
end
