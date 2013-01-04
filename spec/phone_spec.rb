require 'spec_helper'

module Pronounce
  describe Phone do
    describe '.all' do
      it 'lists all English phones' do
        Phone.all.should == {AA => 'vowel',     L  => 'liquid',
                             AE => 'vowel',     M  => 'nasal',
                             AH => 'vowel',     N  => 'nasal',
                             AO => 'vowel',     NG => 'nasal',
                             AW => 'vowel',     OW => 'vowel',
                             AY => 'vowel',     OY => 'vowel',
                             B  => 'stop',      P  => 'stop',
                             CH => 'affricate', R  => 'liquid',
                             D  => 'stop',      S  => 'fricative',
                             DH => 'fricative', SH => 'fricative',
                             EH => 'vowel',     T  => 'stop',
                             ER => 'vowel',     TH => 'fricative',
                             EY => 'vowel',     UH => 'vowel',
                             F  => 'fricative', UW => 'vowel',
                             G  => 'stop',      V  => 'fricative',
                             HH => 'aspirate',  W  => 'semivowel',
                             IH => 'vowel',     Y  => 'semivowel',
                             IY => 'vowel',     Z  => 'fricative',
                             JH => 'affricate', ZH => 'fricative',
                             K  => 'stop'}
      end
    end

    describe '.create' do
      it 'creates an instance of the matching type of Phone' do
        Phone.create('OY2').should be_an_instance_of OY
      end

      it 'fails if there is no matching, legal phone' do
        expect { Phone.create('ZA') }.to raise_error NameError
      end
    end

    describe '#<=>' do
      it 'is comparable based on sonority' do
        Phone.create('AH').should == Phone.create('UW')
        Phone.create('P').should be <  Phone.create('CH')
        Phone.create('F').should be <= Phone.create('Z')
        Phone.create('M').should be >= Phone.create('N')
        Phone.create('W').should be >  Phone.create('R')
      end

      it 'fails when trying to compare to a non-Phone' do
        expect { Phone.create('P') < 'CH' }.to raise_error ArgumentError
      end
    end

    describe '#eql?' do
      subject { Phone.create('AH') }

      it 'is true for an instance of the same Phone' do
        should eql Phone.create('AH')
      end

      it 'is false for a different Phones' do
        should_not eql Phone.create('UW')
      end

      it 'is false for a non-Phone' do
        should_not eql 'AH'
      end
    end

    describe '#syllabic?' do
      it 'is true for vowels' do
        Phone.create('AA').syllabic?.should be_true
      end

      it 'is false for consonants' do
        Phone.create('ZH').syllabic?.should be_false
      end
    end

    describe '#to_s' do
      it 'includes the symbol and stress' do
        Phone.create('OY2').to_s.should == 'OY2'
      end
    end

  end
end
