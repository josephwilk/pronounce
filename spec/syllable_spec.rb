require 'spec_helper'
require 'syllable'

module Pronounce
  describe Syllable do
    subject { make_syllable %w[AE1 D Z] }

    its(:to_strings) { should == %w[AE1 D Z] }
    its(:length) { should == 3 }

    context 'with a nucleus and coda' do
      describe '#coda_contains' do
        it 'part of the coda is true' do
          expect(subject.coda_contains? Phone.new('D')).to be true
        end
      end

      its(:light?) { should == false }
    end

    context 'with no coda and a nucleus' do
      context 'which is short' do
        subject { make_syllable %w[B IH1] }

        its(:light?) { should == true }
      end

      context 'which is long' do
        subject { make_syllable %w[B AY1] }

        its(:light?) { should == false }
      end
    end

    context 'with an onset only (pending syllables only)' do
      subject { make_syllable %w[N] }

      describe '#coda_contains' do
        it 'part of the onset is false' do
          expect(subject.coda_contains? Phone.new('N')).to be false
        end
      end
    end

    context 'with a stressed vowel' do
      its(:stressed?) { should == true }
    end

    context 'with an unstressed vowel' do
      subject { make_syllable %w[AH0 N] }
      its(:stressed?) { should == false }
    end

  end
end
