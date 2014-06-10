require 'spec_helper'
require 'pronounce/phone_type'

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

    describe '#articulation?' do
      let(:type) { PhoneType['JH'] }

      it 'is true for the correct articulation' do
        expect(type.articulation?(:affricate)).to be true
      end

      it 'is true for a list containing the correct articulation' do
        expect(type.articulation?(:affricate, :vowel)).to be true
      end

      it 'is false for an incorrect articulation' do
        expect(type.articulation?(:stop)).to be false
      end

      it 'is false for a list not containing the correct articulation' do
        expect(type.articulation?(:stop, :vowel)).to be false
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

    describe '#voiced?' do
      it 'is true for vowels' do
        expect(PhoneType['AE'].voiced?).to be true
      end

      it 'is true for voiced consonants' do
        expect(PhoneType['D'].voiced?).to be true
      end

      it 'is false for unvoiced consonants' do
        expect(PhoneType['CH'].voiced?).to be false
      end
    end

    it '#voiceless? is the opposite of #voiced?' do
      expect(PhoneType['JH'].voiceless?).to be false
    end

  end
end
