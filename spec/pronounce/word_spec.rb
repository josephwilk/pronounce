# encoding: UTF-8

require 'pronounce/word'

module Pronounce
  describe Word do
    describe '#syllables' do
      let(:syllables) do
        Word.new(raw_phones).syllables.map { |syllable| syllable.to_strings }
      end

      context 'for a word' do
        let(:raw_phones) { %w[M AH1 NG K] } # monk

        it 'returns a list of phones' do
          expect(syllables).to eq [%w[M AH1 NG K]]
        end
      end

      context 'for a multi-syllable word' do
        let(:raw_phones) { %w[M AH1 NG K IY0 Z] } # monkeys

        it 'groups its phones by syllable' do
          expect(syllables).to eq [%w[M AH1 NG], %w[K IY0 Z]]
        end
      end

      describe 'English rules' do
        context 'for a word with a non-final /ŋ/' do
          let(:raw_phones) { %w[HH AE1 NG IH0 NG] } # hanging

          it 'applies disallow /ŋ/ onset rule' do
            expect(syllables).to eq [%w[HH AE1 NG], %w[IH0 NG]]
          end
        end

        context 'for a word with a stressed short vowel' do
          let(:raw_phones) { %w[HH IH1 L AH0 K] } # hillock

          it 'applies stressed syllables must be heavy rule' do
            expect(syllables).to eq [%w[HH IH1 L], %w[AH0 K]]
          end
        end

        context 'for a word with a two consonant cluster' do
          let(:raw_phones) { %w[IY1 V N IH0 NG] } # evening

          it 'applies doublet onsets rule' do
            expect(syllables).to eq [%w[IY1 V], %w[N IH0 NG]]
          end
        end

        context 'for a word with a cluster starting in /s/' do
          let(:raw_phones) { %w[S P L IH1 T] } # split

          it 'applies /s/ cluster onsets rule' do
            expect(syllables).to eq [%w[S P L IH1 T]]
          end
        end

        context 'for a word with a two consonant cluster starting in /s/' do
          let(:raw_phones) { %w[B AY1 OW0 S F IH2 R] } # biosphere

          it 'the correct rule is applied' do
            expect(syllables).to eq [%w[B AY1], %w[OW0], %w[S F IH2 R]]
          end
        end
      end
    end

  end
end
