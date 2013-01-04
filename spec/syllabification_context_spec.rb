require 'spec_helper'

module Pronounce
  describe SyllabificationContext do
    subject { SyllabificationContext.new test_word, index }

    let(:test_word) { build_word 'AH0', 'N', 'D' }

    context 'for the first phone' do
      let(:index) { 0 }

      it { should be_word_beginning }
      it { should_not be_word_end }
      its(:current_phone) { should be_an AH }
      its(:next_phone) { should be_an N }
      its(:previous_phone) { should be_nil }
    end

    context 'for the middle phone' do
      let(:index) { 1 }

      it { should_not be_word_beginning }
      it { should_not be_word_end }
      its(:current_phone) { should be_an N }
      its(:next_phone) { should be_a D }
      its(:previous_phone) { should be_an AH }
    end

    context 'for the last phone' do
      let(:index) { 2 }

      it { should_not be_word_beginning }
      it { should be_word_end }
      its(:current_phone) { should be_a D }
      its(:next_phone) { should be_nil }
      its(:previous_phone) { should be_an N }
    end

  end
end
