require 'spec_helper'
require 'syllable_rules'
require 'syllable_rules/english'
require 'syllabification_context'

module Pronounce
  describe SyllableRules do
    describe 'stressed syllables cannot be light' do
      subject do
        context = Pronounce::SyllabificationContext.new syllables, phones, index
        SyllableRules[:en]['stressed syllables cannot be light'].evaluate context
      end

      let(:syllables) { [] }
      let(:phones) { make_phones %w[AE1 B D AH0 K EY2 T S] } # abdicates

      context 'following stressed, unbranching syllable' do
        let(:index) { 1 }
        it { should == false }
      end

      context 'following stressed syllable with braching rime' do
        let(:index) { 2 }
        it { should == nil }
      end

      context 'following unstressed, unbranching syllable' do
        let(:syllables) { [make_syllable(%w[AE1 B])] }
        let(:index) { 4 }
        it { should == nil }
      end

      context 'following stressed syllable with branching nucleus' do
        let(:syllables) { [make_syllable(%w[AE1 B]), make_syllable(%w[D AH0])] }
        let(:index) { 6 }
        it { should == nil }
      end

    end
  end
end
