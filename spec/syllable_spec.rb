require 'spec_helper'

module Pronounce
  describe Syllable do
    subject { make_syllable 'AE1', 'D', 'Z' }

    its(:to_strings) { should == ['AE1', 'D', 'Z'] }
    its(:length) { should == 3 }

    context 'with a nucleus and coda' do
      subject { make_syllable 'AE1', 'D', 'Z' }

      describe '#coda_contains' do
        it 'part of the coda is true' do
          expect(subject.coda_contains? Phone.create('D')).to eq true
        end
      end
    end

    context 'with only and onset (pending syllables only)' do
      subject { make_syllable 'N' }

      describe '#coda_contains' do
        it 'part of the onset is false' do
          expect(subject.coda_contains? Phone.create('N')).to eq false
        end
      end
    end

  end
end
