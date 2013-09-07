require 'phone_type'

module Pronounce
  describe PhoneType do
    it 'does not allow creation of new instances' do
      expect { PhoneType.new }.to raise_error NoMethodError
    end

    describe '#<=>' do
      it 'is based on sonority' do
        expect(PhoneType['AH']).to eq PhoneType['UW']
        expect(PhoneType['P']).to be <  PhoneType['CH']
        expect(PhoneType['F']).to be <= PhoneType['Z']
        expect(PhoneType['M']).to be >= PhoneType['N']
        expect(PhoneType['W']).to be >  PhoneType['R']
      end

      it 'fails when trying to compare to a non-PhoneType object' do
        expect { PhoneType['P'] < 'CH' }.to raise_error ArgumentError
      end
    end

    describe '#short?' do
      it 'is true for short vowels' do
        expect(PhoneType['AE'].short?).to be true
      end

      it 'is false for long vowels' do
        expect(PhoneType['AY'].short?).to be false
      end

      it 'is false for consonants' do
        expect(PhoneType['ZH'].short?).to be false
      end
    end

    describe '#syllabic?' do
      it 'is true for vowels' do
        expect(PhoneType['AA'].syllabic?).to be true
      end

      it 'is false for consonants' do
        expect(PhoneType['ZH'].syllabic?).to be false
      end
    end

  end
end
