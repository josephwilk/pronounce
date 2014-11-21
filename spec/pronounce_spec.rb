require 'spec_helper'
require 'pronounce'

describe Pronounce do
  describe '.how_do_i_pronounce' do
    before do
      allow(Pronounce::DataReader).to receive(:pronunciations) {
        [
          ';;; # CMUdict  --  Major Version: 0.07a [102007]',
          'FOP  F AO1 P',
          'FOP(1)  EH1 F OW1 P IY1',
          'MONKEYS  M AH1 NG K IY0 Z'
        ]
      }
    end

    it 'returns a list of phones' do
      expect(Pronounce.how_do_i_pronounce('fop')).to eq [%w(F AO1 P)]
    end

    it 'groups the phones by syllable' do
      expect(Pronounce.how_do_i_pronounce('monkeys')).to eq [%w[M AH1 NG], %w[K IY0 Z]]
    end

    it 'returns nil for unknown words' do
      expect(Pronounce.how_do_i_pronounce('beeblebrox')).to be nil
    end

    it 'is case insensitive' do
      expect(Pronounce.how_do_i_pronounce('FoP')).to eq [%w(F AO1 P)]
    end

    it "doesn't import commented lines in the pronunciations file" do
      expect(Pronounce.how_do_i_pronounce(';;;')).to be nil
    end

    it "doesn't import additional pronunciations" do
      expect(Pronounce.how_do_i_pronounce('fop(1)')).to be nil
    end
  end

end
