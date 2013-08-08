require 'spec_helper'
require 'syllabification_context'

module Pronounce
  describe SyllabificationContext do
    subject { SyllabificationContext.new syllables, phones, index }

    let(:syllables) { [make_syllable(%w[AE0 N])] }
    let(:phones) { make_phones %w[AE0 N D R AA1 M AH0 D AH0] } # Andromeda

    context 'for the first phone' do
      let(:index) { 0 }

      it { should be_word_beginning }
      it { should_not be_word_end }
      its(:current_phone) { should eq Phone.new 'AE' }
      its(:next_phone) { should eq Phone.new 'N' }
      its(:previous_phone) { should be_nil }
    end

    context 'for a middle phone' do
      let(:index) { 1 }

      it { should_not be_word_beginning }
      it { should_not be_word_end }
      its(:current_phone) { should eq Phone.new 'N' }
      its(:next_phone) { should eq Phone.new 'D' }
      its(:previous_phone) { should eq Phone.new 'AE' }
    end

    context 'for the last phone' do
      let(:index) { 8 }

      it { should_not be_word_beginning }
      it { should be_word_end }
      its(:current_phone) { should eq Phone.new 'AH' }
      its(:next_phone) { should be_nil }
      its(:previous_phone) { should eq Phone.new 'D' }
    end

    describe '#pending_syllable' do
      let(:index) { 4 }

      it 'is everything between the completed syllables and the current phone' do
        expect(subject.pending_syllable.to_strings).to eq %w[D R]
      end
    end

    describe '#previous_phone_in_coda?' do
      context 'when pending syllable contains a vowel before previous phone' do
        let(:syllables) { [] }
        let(:index) { 2 }

        it 'is true' do
          expect(subject.previous_phone_in_coda?).to be true
        end
      end

      context 'when pending syllable does not contain a vowel before previous phone' do
        let(:index) { 4 }

        it 'is false' do
          expect(subject.previous_phone_in_coda?).to be false
        end
      end
    end

    describe '#previous_phone_in_onset?' do
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
      let(:syllables) { [] }
      let(:phones) { make_phones %w[B AE1 K P AE2 K ER0] } # backpacker

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

  end
end
