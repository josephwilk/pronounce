# encoding: UTF-8

require 'spec_helper'
require 'word'

module Pronounce
  describe Word do
    describe '#syllables' do
      subject { word.syllables.map {|syllable| syllable.to_strings } }

      describe 'returns a list of phones' do
        let(:word) { Word.new %w[M AH1 NG K] } # monk
        it { should == [%w[M AH1 NG K]] }
      end

      describe 'groups the phones by syllable' do
        let(:word) { Word.new %w[M AH1 NG K IY0 Z] } # monkeys
        it { should == [%w[M AH1 NG], %w[K IY0 Z]] }
      end

      describe 'applies English rules' do
        context 'for /ŋ/' do
          let(:word) { Word.new %w[HH AE1 NG IH0 NG] } # hanging
          it { should == [%w[HH AE1 NG], %w[IH0 NG]] }
        end

        context 'for light, stressed syllables' do
          let(:word) { Word.new %w[HH IH1 L AH0 K] } # hillock
          it { should == [%w[HH IH1 L], %w[AH0 K]] }
        end

        context 'for word initial triplet onsets' do
          let(:word) { Word.new %w[S P L IH1 T] } # split
          it { should == [%w[S P L IH1 T]] }
        end
      end
    end

  end
end
