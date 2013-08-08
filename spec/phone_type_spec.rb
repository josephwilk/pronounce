require 'phone_type'

module Pronounce
  describe PhoneType do
    describe '.all' do
      it 'lists all English phones' do
        expect(PhoneType.all).to eq({
          PhoneType['AA'] => Articulation[:vowel],
          PhoneType['AE'] => Articulation[:vowel],
          PhoneType['AH'] => Articulation[:vowel],
          PhoneType['AO'] => Articulation[:vowel],
          PhoneType['AW'] => Articulation[:vowel],
          PhoneType['AY'] => Articulation[:vowel],
          PhoneType['B']  => Articulation[:stop],
          PhoneType['CH'] => Articulation[:affricate],
          PhoneType['D']  => Articulation[:stop],
          PhoneType['DH'] => Articulation[:fricative],
          PhoneType['EH'] => Articulation[:vowel],
          PhoneType['ER'] => Articulation[:vowel],
          PhoneType['EY'] => Articulation[:vowel],
          PhoneType['F']  => Articulation[:fricative],
          PhoneType['G']  => Articulation[:stop],
          PhoneType['HH'] => Articulation[:aspirate],
          PhoneType['IH'] => Articulation[:vowel],
          PhoneType['IY'] => Articulation[:vowel],
          PhoneType['JH'] => Articulation[:affricate],
          PhoneType['K']  => Articulation[:stop],
          PhoneType['L']  => Articulation[:liquid],
          PhoneType['M']  => Articulation[:nasal],
          PhoneType['N']  => Articulation[:nasal],
          PhoneType['NG'] => Articulation[:nasal],
          PhoneType['OW'] => Articulation[:vowel],
          PhoneType['OY'] => Articulation[:vowel],
          PhoneType['P']  => Articulation[:stop],
          PhoneType['R']  => Articulation[:liquid],
          PhoneType['S']  => Articulation[:fricative],
          PhoneType['SH'] => Articulation[:fricative],
          PhoneType['T']  => Articulation[:stop],
          PhoneType['TH'] => Articulation[:fricative],
          PhoneType['UH'] => Articulation[:vowel],
          PhoneType['UW'] => Articulation[:vowel],
          PhoneType['V']  => Articulation[:fricative],
          PhoneType['W']  => Articulation[:semivowel],
          PhoneType['Y']  => Articulation[:semivowel],
          PhoneType['Z']  => Articulation[:fricative],
          PhoneType['ZH'] => Articulation[:fricative]
        })
      end
    end

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

    describe '#inspect' do
      it 'returns the name' do
        expect(PhoneType['AE'].inspect).to eq 'AE'
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
