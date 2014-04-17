require 'spec_helper'
require 'pronounce/syllabification_context'
require 'pronounce/syllable_rules'
require 'pronounce/syllable_rules/english'

module Pronounce
  describe SyllableRules do
    describe 'stressed syllables cannot be light' do
      subject do
        phones = make_phones(raw_phones)
        context = Pronounce::SyllabificationContext.new(syllables, phones, index)
        SyllableRules[:en]['stressed syllables cannot be light'].evaluate(context)
      end

      let(:syllables) { [] }
      let(:raw_phones) { %w[AE1 B D AH0 K EY2 T S] } # abdicates

      context 'following stressed, unbranching syllable' do
        let(:index) { 1 }
        it { should be :no_new_syllable }
      end

      context 'following stressed syllable with braching rime' do
        let(:index) { 2 }
        it { should be :not_applicable }
      end

      context 'following unstressed, unbranching syllable' do
        let(:syllables) { [make_syllable(%w[AE1 B])] }
        let(:index) { 4 }
        it { should be :not_applicable }
      end

      context 'following stressed syllable with branching nucleus' do
        let(:syllables) { [make_syllable(%w[AE1 B]), make_syllable(%w[D AH0])] }
        let(:index) { 6 }
        it { should be :not_applicable }
      end

    end
  end
end
