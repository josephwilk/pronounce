require 'data_reader'

module Pronounce
  describe DataReader do
    subject { DataReader.new }

    its(:phones) { should include "AA\tvowel\n" }
    its(:pronunciations) { should include ";;; # CMUdict  --  Major Version: 0.07a [102007]\n" }
    its(:symbols) { should include "AA\r\n" }

  end
end
