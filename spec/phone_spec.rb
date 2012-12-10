require_relative '../lib/phone'

module Pronounce
  describe Phone do
    describe ".all" do
      it 'lists all English phones' do
        Phone.all.inspect.should == '[AA (vowel),' +
                                    ' AE (vowel),' +
                                    ' AH (vowel),' +
                                    ' AO (vowel),' +
                                    ' AW (vowel),' +
                                    ' AY (vowel),' +
                                    ' B (stop),' +
                                    ' CH (affricate),' +
                                    ' D (stop),' +
                                    ' DH (fricative),' +
                                    ' EH (vowel),' +
                                    ' ER (vowel),' +
                                    ' EY (vowel),' +
                                    ' F (fricative),' +
                                    ' G (stop),' +
                                    ' HH (aspirate),' +
                                    ' IH (vowel),' +
                                    ' IY (vowel),' +
                                    ' JH (affricate),' +
                                    ' K (stop),' +
                                    ' L (liquid),' +
                                    ' M (nasal),' +
                                    ' N (nasal),' +
                                    ' NG (nasal),' +
                                    ' OW (vowel),' +
                                    ' OY (vowel),' +
                                    ' P (stop),' +
                                    ' R (liquid),' +
                                    ' S (fricative),' +
                                    ' SH (fricative),' +
                                    ' T (stop),' +
                                    ' TH (fricative),' +
                                    ' UH (vowel),' +
                                    ' UW (vowel),' +
                                    ' V (fricative),' +
                                    ' W (semivowel),' +
                                    ' Y (semivowel),' +
                                    ' Z (fricative),' +
                                    ' ZH (fricative)]'
      end
    end

    describe '.find' do
      it 'returns the corresponding Phone for the symbol' do
        Phone.find('OY2').inspect.should == 'OY (vowel)'
      end
    end

    describe '#to_s' do
      it 'includes the symbol and articulation' do
        Phone.find('ZH').to_s.should == 'ZH (fricative)'
      end
    end

    it 'is comparable based on sonority' do
      Phone.find('P').should < Phone.find('CH')
      Phone.find('F').should <= Phone.find('Z')
      Phone.find('M').should >= Phone.find('N')
      Phone.find('W').should > Phone.find('R')
    end

  end
end
