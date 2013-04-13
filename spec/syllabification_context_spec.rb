require 'spec_helper'

module Pronounce
  describe SyllabificationContext do
    subject { SyllabificationContext.new syllables, phones, index }

    let(:syllables) { [make_syllable('AE0', 'N')] }
    let(:phones) { make_phones 'AE0', 'N', 'D', 'R', 'AA1', 'M', 'AH0', 'D', 'AH0' }

    context 'for the first phone' do
      let(:index) { 0 }

      it { should be_word_beginning }
      it { should_not be_word_end }
      its(:current_phone) { should be_an AE }
      its(:next_phone) { should be_an N }
      its(:previous_phone) { should be_nil }
    end

    context 'for a middle phone' do
      let(:index) { 1 }

      it { should_not be_word_beginning }
      it { should_not be_word_end }
      its(:current_phone) { should be_an N }
      its(:next_phone) { should be_a D }
      its(:previous_phone) { should be_an AE }
    end

    context 'for the last phone' do
      let(:index) { 8 }

      it { should_not be_word_beginning }
      it { should be_word_end }
      its(:current_phone) { should be_a AH }
      its(:next_phone) { should be_nil }
      its(:previous_phone) { should be_an D }
    end

    describe '#pending_syllable' do
      let(:index) { 4 }

      it 'is everything between the completed syllables and the current phone' do
        expect(subject.pending_syllable.to_strings).to eq ['D', 'R']
      end
    end

  end
end
