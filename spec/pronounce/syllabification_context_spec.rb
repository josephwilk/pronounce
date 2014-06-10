require 'spec_helper'
require 'spec_helper_methods'
require 'pronounce/syllabification_context'

module Pronounce
  describe SyllabificationContext do
    subject { SyllabificationContext.new syllables, phones, index }

    let(:syllables) { [] }
    let(:phones) { make_phones(%w(AE0 N D R AA1 M AH0 D AH0)) } # Andromeda

    describe '#current_onset' do
      let(:phones) { make_phones(%w(S P R AE1 NG)) } # sprang

      context 'at the start of an onset' do
        let(:index) { 0 }

        it 'returns the whole onset' do
          expect(subject.current_onset).to eq make_phones(%w[S P R])
        end
      end

      context 'in the middle of an onset' do
        let(:index) { 1 }

        it 'returns the whole onset' do
          expect(subject.current_onset).to eq make_phones(%w[S P R])
        end
      end

      context 'at the end of an onset' do
        let(:index) { 2 }

        it 'returns the whole onset' do
          expect(subject.current_onset).to eq make_phones(%w[S P R])
        end
      end

      context 'when a previous phone is in a coda' do
        let(:syllables) { [make_syllable(%w[EH1 K])] }
        let(:phones) { make_phones(%w(EH1 K S P L OY2 T)) } # exploit
        let(:index) { 3 }

        it 'that phone is not included' do
          expect(subject.current_onset).to eq make_phones(%w[S P L])
        end
      end

      context 'when the previous phone is in a coda' do
        let(:phones) { make_phones(%w(EH1 K S P L OY2 T)) } # exploit
        let(:index) { 2 }

        it 'that phone is not included' do
          expect(subject.current_onset).to eq make_phones(%w[S P L])
        end
      end

      context 'when the current phone is in a coda' do
        let(:phones) { make_phones(%w(T R UW1 TH S)) } # truths
        let(:index) { 3 }

        it 'returns an empty array' do
          expect(subject.current_onset).to eq []
        end
      end

      context 'on a vowel' do
        let(:index) { 3 }

        it 'returns an empty array' do
          expect(subject.current_onset).to eq []
        end
      end

      context 'when the next vowel has the same phone type as a previous vowel' do
        let(:phones) { make_phones(%w(IH0 V EH1 N CH AH0 W AH0 L IY0)) } # eventually
        let(:index) { 6 }

        it 'returns the whole onset' do
          expect(subject.current_onset).to eq make_phones(%w[W])
        end
      end
    end

    describe '#current_phone' do
      let(:index) { 1 }

      it 'returns the correct phone' do
        expect(subject.current_phone).to eq Phone.new('N')
      end
    end

    describe '#next_phone' do
      context 'for the last phone' do
        let(:index) { 8 }

        it 'is nil' do
          expect(subject.next_phone).to be_nil
        end
      end

      context 'for not the last phone' do
        let(:index) { 2 }

        it 'returns the correct phone' do
          expect(subject.next_phone).to eq Phone.new('R')
        end
      end
    end

    describe '#pending_syllable' do
      let(:syllables) { [make_syllable(%w[AE0 N])] }
      let(:index) { 4 }

      it 'is everything between the completed syllables and the current phone' do
        expect(subject.pending_syllable.to_strings).to eq %w[D R]
      end
    end

    describe '#previous_phone' do
      context 'for the first phone' do
        let(:index) { 0 }

        it 'is nil' do
          expect(subject.previous_phone).to be_nil
        end
      end

      context 'for not the first phone' do
        let(:index) { 3 }

        it 'returns the correct phone' do
          expect(subject.previous_phone).to eq Phone.new('D')
        end
      end
    end

    describe '#previous_phone_in_coda?' do
      context 'when pending syllable contains a vowel before previous phone' do
        let(:index) { 2 }

        it 'is true' do
          expect(subject.previous_phone_in_coda?).to be true
        end
      end

      context 'when pending syllable does not contain a vowel before previous phone' do
        let(:syllables) { [make_syllable(%w[AE0 N])] }
        let(:index) { 4 }

        it 'is false' do
          expect(subject.previous_phone_in_coda?).to be false
        end
      end
    end

    describe '#previous_phone_in_onset?' do
      let(:syllables) { [make_syllable(%w[AE0 N])] }

      context 'when pending syllable does not contain a vowel' do
        let(:index) { 4 }

        it 'is true' do
          expect(subject.previous_phone_in_onset?).to be true
        end
      end

      context 'when pending syllable contains a vowel' do
        let(:index) { 6 }

        it 'is false' do
          expect(subject.previous_phone_in_onset?).to be false
        end
      end
    end

    describe '#sonority_trough?' do
      let(:phones) { make_phones(%w(B AE1 K P AE2 K ER0)) } # backpacker

      context 'when current phone is less than next and previous' do
        let(:index) { 5 }

        it 'is true' do
          expect(subject.sonority_trough?).to be true
        end
      end

      context 'when current phone is less than next and equal to previous' do
        let(:index) { 3 }

        it 'is true' do
          expect(subject.sonority_trough?).to be true
        end
      end
    end

    describe '#word_beginning?' do
      context 'for the first phone' do
        let(:index) { 0 }

        it 'is true' do
          expect(subject.word_beginning?).to be true
        end
      end

      context 'for a middle phone' do
        let(:index) { 1 }

        it 'is false' do
          expect(subject.word_beginning?).to be false
        end
      end

      context 'for the last phone' do
        let(:index) { 8 }

        it 'is false' do
          expect(subject.word_beginning?).to be false
        end
      end
    end

    describe '#word_end?' do
      context 'for the first phone' do
        let(:index) { 0 }

        it 'is false' do
          expect(subject.word_end?).to be false
        end
      end

      context 'for a middle phone' do
        let(:index) { 1 }

        it 'is false' do
          expect(subject.word_end?).to be false
        end
      end

      context 'for the last phone' do
        let(:index) { 8 }

        it 'is true' do
          expect(subject.word_end?).to be true
        end
      end
    end

  end
end
