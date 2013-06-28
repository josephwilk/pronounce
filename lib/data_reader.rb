module Pronounce
  class DataReader
    CMUDICT_VERSION = '0.7a'
    DATA_DIR = File.dirname(__FILE__) + '/../data'

    def phones
      File.readlines "#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones"
    end

    def pronunciations
      File.readlines "#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}"
    end

    def symbols
      File.readlines "#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.symbols"
    end

  end
end
