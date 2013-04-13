require 'spec_helper'

describe Pronounce do
  describe '.how_do_i_pronounce' do
    it 'returns a list of phones' do
      Pronounce.how_do_i_pronounce('monk').should == [['M', 'AH1', 'NG', 'K']]
    end

    it 'groups the phones by syllable' do
      Pronounce.how_do_i_pronounce('monkeys').should == [['M', 'AH1', 'NG'], ['K', 'IY0', 'Z']]
    end

    it 'returns nil for unknown words' do
      Pronounce.how_do_i_pronounce('beeblebrox').should == nil
    end
  end

  describe '.symbols' do
    it 'lists all symbols' do
      Pronounce.symbols.should == ['AA',  'AA0', 'AA1', 'AA2', 'AE',  'AE0',
                                   'AE1', 'AE2', 'AH',  'AH0', 'AH1', 'AH2',
                                   'AO',  'AO0', 'AO1', 'AO2', 'AW',  'AW0',
                                   'AW1', 'AW2', 'AY',  'AY0', 'AY1', 'AY2',
                                   'B',   'CH',  'D',   'DH',  'EH',  'EH0',
                                   'EH1', 'EH2', 'ER',  'ER0', 'ER1', 'ER2',
                                   'EY',  'EY0', 'EY1', 'EY2', 'F',   'G',
                                   'HH',  'IH',  'IH0', 'IH1', 'IH2', 'IY',
                                   'IY0', 'IY1', 'IY2', 'JH',  'K',   'L',
                                   'M',   'N',   'NG',  'OW',  'OW0', 'OW1',
                                   'OW2', 'OY',  'OY0', 'OY1', 'OY2', 'P',
                                   'R',   'S',   'SH',  'T',   'TH',  'UH',
                                   'UH0', 'UH1', 'UH2', 'UW',  'UW0', 'UW1',
                                   'UW2', 'V',   'W',   'Y',   'Z',   'ZH']
    end
  end

end
