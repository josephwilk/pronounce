require 'spec_helper'
require 'phone'

module Pronounce
  describe Phone do
    describe '.new' do
      it 'fails if symbol is not in Pronounce.symbols' do
        expect { Phone.new 'ZA' }.to raise_error ArgumentError
      end
    end

    describe '#<=>' do
      it 'is based on sonority' do
        expect(Phone.new 'AH').to eq Phone.new('UW')
        expect(Phone.new 'P').to be <  Phone.new('CH')
        expect(Phone.new 'F').to be <= Phone.new('Z')
        expect(Phone.new 'M').to be >= Phone.new('N')
        expect(Phone.new 'W').to be >  Phone.new('R')
      end

      it 'fails when trying to compare to a non-Phone' do
        expect { Phone.new('P') < 'CH' }.to raise_error ArgumentError
      end
    end

    describe '#approximant?' do
      it 'is true for a liquid' do
        expect(Phone.new('R').approximant?).to be true
      end

      it 'is true for a glide' do
        expect(Phone.new('W').approximant?).to be true
      end

      it 'is false for non-approximants' do
        expect(Phone.new('P').approximant?).to be false
      end
    end

    describe '#articulation?' do
      let(:phone) { Phone.new 'JH' }

      it 'is true for the correct articulation' do
        expect(phone.articulation? :affricate).to be true
      end

      it 'is true for a list containing the correct articulation' do
        expect(phone.articulation? :affricate, :vowel).to be true
      end

      it 'is false for an incorrect articulation' do
        expect(phone.articulation? :stop).to be false
      end

      it 'is false for a list not containing the correct articulation' do
        expect(phone.articulation? :stop, :vowel).to be false
      end
    end

    describe '#eql?' do
      let(:phone) { Phone.new 'AH' }

      it 'is true for an instance of the same phone' do
        expect(phone).to eql Phone.new('AH')
      end

      it 'is false for an instance of a different phone' do
        expect(phone).to_not eql Phone.new('UW')
      end

      it 'is false for a non-Phone' do
        expect(phone).to_not eql 'AH'
      end
    end

    describe '#hash' do
      let(:hash) { Phone.new('AH').hash }

      it 'is the same for an instance of the same phone' do
        expect(hash).to eq Phone.new('AH').hash
      end

      it 'is different for an instance of a different phone' do
        expect(hash).to_not eq Phone.new('UW').hash
      end

      it 'is different for a non-Phone' do
        expect(hash).to_not eq 'AH'.hash
      end
    end

    describe '#short?' do
      it 'is true for short vowels' do
        expect(Phone.new('AE').short?).to be true
      end

      it 'is false for long vowels' do
        expect(Phone.new('AY').short?).to be false
      end

      it 'is false for consonants' do
        expect(Phone.new('ZH').short?).to be false
      end
    end

    describe '#stress' do
      it 'is an integer' do
        expect(Phone.new('OY2').stress).to be 2
      end

      it 'is nil for consonants' do
        expect(Phone.new('ZH').stress).to be_nil
      end
    end

    describe '#syllabic?' do
      it 'is true for vowels' do
        expect(Phone.new('AA').syllabic?).to be true
      end

      it 'is false for consonants' do
        expect(Phone.new('ZH').syllabic?).to be false
      end
    end

    describe '#to_s' do
      it 'includes the type and stress' do
        expect(Phone.new('OY2').to_s).to eq 'OY2'
      end
    end

    describe '#voiced?' do
      it 'is true for vowels' do
        expect(Phone.new('AE').voiced?).to be true
      end

      it 'is true for voiced consonants' do
        expect(Phone.new('D').voiced?).to be true
      end

      it 'is false for unvoiced consonants' do
        expect(Phone.new('CH').voiced?).to be false
      end
    end

  end
end
