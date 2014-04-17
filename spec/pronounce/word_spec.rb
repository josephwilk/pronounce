# encoding: UTF-8

require 'pronounce/word'

module Pronounce
  describe Word do
    describe '#syllables' do
      subject {
        word = Word.new(raw_phones)
        word.syllables.map {|syllable| syllable.to_strings }
      }

      describe 'returns a list of phones' do
        let(:raw_phones) { %w[M AH1 NG K] } # monk
        it { should == [%w[M AH1 NG K]] }
      end

      describe 'groups the phones by syllable' do
        let(:raw_phones) { %w[M AH1 NG K IY0 Z] } # monkeys
        it { should == [%w[M AH1 NG], %w[K IY0 Z]] }
      end

      describe 'applies English rules' do
        context 'for /ŋ/' do
          let(:raw_phones) { %w[HH AE1 NG IH0 NG] } # hanging
          it { should == [%w[HH AE1 NG], %w[IH0 NG]] }
        end

        context 'for light, stressed syllables' do
          let(:raw_phones) { %w[HH IH1 L AH0 K] } # hillock
          it { should == [%w[HH IH1 L], %w[AH0 K]] }
        end

        context 'for doublet onsets' do
          let(:raw_phones) { %w[IY1 V N IH0 NG] } # evening
          it { should == [%w[IY1 V], %w[N IH0 NG]] }
        end

        context 'for /s/ cluster onsets' do
          let(:raw_phones) { %w[S P L IH1 T] } # split
          it { should == [%w[S P L IH1 T]] }
        end

        context 'without doublet onsets rule conflicting with /s/ cluster onsets rule' do
          let(:raw_phones) { %w[B AY1 OW0 S F IH2 R] } # biosphere
          it { should == [%w[B AY1], %w[OW0], %w[S F IH2 R]] }
        end
      end
    end

  end
end
