require 'data_reader'

module Pronounce
  describe DataReader do
    subject { DataReader }

    its(:articulations) { should include "AA\tvowel\n" }
    its(:phonations) { should include "AA\tvoiced\n" }
    its(:pronunciations) { should include ";;; # CMUdict  --  Major Version: 0.07a [102007]\n" }

  end
end
