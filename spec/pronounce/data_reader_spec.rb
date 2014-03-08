require 'pronounce/data_reader'

module Pronounce
  describe DataReader do
    let(:its) { DataReader }

    it 'loads the articulations file' do
      expect(its.articulations).to include "AA\tvowel\n"
    end

    it 'loads the phonations file' do
      expect(its.phonations).to include "AA\tvoiced\n"
    end

    it 'loads the pronunciations file' do
      expect(its.pronunciations).to include ";;; # CMUdict  --  Major Version: 0.07a [102007]\n"
    end

  end
end
