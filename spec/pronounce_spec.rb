require 'spec_helper'
require 'pronounce'

describe Pronounce do
  describe '.how_do_i_pronounce' do
    before do
      allow(Pronounce::DataReader).to receive(:pronunciations) {
        ['MONK  M AH1 NG K', 'MONKEYS  M AH1 NG K IY0 Z']
      }
    end

    it 'returns a list of phones' do
      expect(Pronounce.how_do_i_pronounce('monk')).to eq [%w[M AH1 NG K]]
    end

    it 'groups the phones by syllable' do
      expect(Pronounce.how_do_i_pronounce('monkeys')).to eq [%w[M AH1 NG], %w[K IY0 Z]]
    end

    it 'returns nil for unknown words' do
      expect(Pronounce.how_do_i_pronounce('beeblebrox')).to be nil
    end

    it 'is case insensitive' do
      expect(Pronounce.how_do_i_pronounce('MoNk')).to eq [%w[M AH1 NG K]]
    end
  end

end
