require 'spec_helper'
require 'phone'

module Pronounce
  describe Phone do
    describe '.all' do
      it 'lists all English phones' do
        Phone.all.should == {
          AA => Articulation[:vowel],     L  => Articulation[:liquid],
          AE => Articulation[:vowel],     M  => Articulation[:nasal],
          AH => Articulation[:vowel],     N  => Articulation[:nasal],
          AO => Articulation[:vowel],     NG => Articulation[:nasal],
          AW => Articulation[:vowel],     OW => Articulation[:vowel],
          AY => Articulation[:vowel],     OY => Articulation[:vowel],
          B  => Articulation[:stop],      P  => Articulation[:stop],
          CH => Articulation[:affricate], R  => Articulation[:liquid],
          D  => Articulation[:stop],      S  => Articulation[:fricative],
          DH => Articulation[:fricative], SH => Articulation[:fricative],
          EH => Articulation[:vowel],     T  => Articulation[:stop],
          ER => Articulation[:vowel],     TH => Articulation[:fricative],
          EY => Articulation[:vowel],     UH => Articulation[:vowel],
          F  => Articulation[:fricative], UW => Articulation[:vowel],
          G  => Articulation[:stop],      V  => Articulation[:fricative],
          HH => Articulation[:aspirate],  W  => Articulation[:semivowel],
          IH => Articulation[:vowel],     Y  => Articulation[:semivowel],
          IY => Articulation[:vowel],     Z  => Articulation[:fricative],
          JH => Articulation[:affricate], ZH => Articulation[:fricative],
          K  => Articulation[:stop]
        }
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
      it 'is based on sonority' do
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

      it 'is false for an instance of a different Phone' do
        should_not eql Phone.create('UW')
      end

      it 'is false for a non-Phone' do
        should_not eql 'AH'
      end
    end

    describe '#stress' do
      it 'is an integer' do
        Phone.create('OY2').stress.should == 2
      end

      it 'is nil for consonants' do
        Phone.create('ZH').stress.should be_nil
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
