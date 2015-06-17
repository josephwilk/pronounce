require 'spec_helper'
require 'pronounce/data_reader'

module Pronounce
  describe DataReader do
    subject(:reader) { DataReader }

    it 'loads the articulations file' do
      expect(reader.articulations['AA']).to eq 'vowel'
    end

    it 'loads the phonations file' do
      expect(reader.phonations['AA']).to eq 'voiced'
    end

    it 'loads the pronunciations file' do
      expect(reader.pronunciations).to include ";;; # CMUdict  --  Major Version: 0.07a [102007]\n"
    end
  end
end
