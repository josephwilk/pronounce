require 'spec_helper'
require 'pronounce'

describe Pronounce do
  describe '.how_do_i_pronounce' do
    before do
      Pronounce::DataReader.stub(:pronunciations) {
        ["MONK  M AH1 NG K", "MONKEYS  M AH1 NG K IY0 Z"]
      }
    end

    it 'returns a list of phones' do
      Pronounce.how_do_i_pronounce('monk').should == [%w[M AH1 NG K]]
    end

    it 'groups the phones by syllable' do
      Pronounce.how_do_i_pronounce('monkeys').should == [%w[M AH1 NG], %w[K IY0 Z]]
    end

    it 'returns nil for unknown words' do
      Pronounce.how_do_i_pronounce('beeblebrox').should == nil
    end

    it 'is case insensitive' do
      Pronounce.how_do_i_pronounce('MoNk').should == [%w[M AH1 NG K]]
    end
  end

end
