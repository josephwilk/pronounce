require 'spec_helper'
require 'spec_helper_methods'
require 'pronounce/syllabification_context'
require 'pronounce/syllable_rules'
require 'pronounce/syllable_rules/base'

module Pronounce
  describe SyllableRules do
    describe 'Sonority Sequencing Principle' do
      subject do
        phones = make_phones(raw_phones)
        syllables = raw_syllables.map { |raw| make_syllable(raw) }
        context = Pronounce::SyllabificationContext.new syllables, phones, index
        SyllableRules[:base]['Sonority Sequencing Principle'].evaluate context
      end

      let(:raw_syllables) { [] }
      let(:raw_phones) { %w[OW AA NG T R UW F] }

      context 'for a vowel preceded by another vowel' do
        let(:index) { 1 }
        it { is_expected.to be :new_syllable }
      end

      context 'for a consonant followed by a lower sonority phone' do
        let(:raw_syllables) { [%w[OW]] }
        let(:index) { 2 }
        it { is_expected.to be :no_new_syllable }
      end

      context 'for a sonority trough' do
        let(:raw_syllables) { [%w[OW]] }
        let(:index) { 3 }
        it { is_expected.to be :new_syllable }
      end

      context 'for a phone preceded by a lower sonority phone' do
        let(:raw_syllables) { [%w[OW], %w[AA NG]] }
        let(:index) { 4 }
        it { is_expected.to be :no_new_syllable }
      end

      context 'for a sonority peak' do
        let(:raw_syllables) { [%w[OW], %w[AA NG]] }
        let(:index) { 5 }
        it { is_expected.to be :no_new_syllable }
      end

      context 'for a consonant preceded by another consonant of equal sonority' do
        let(:raw_phones) { %w[Y UW1 S F AH0 L] } # useful
        let(:index) { 3 }
        it { is_expected.to be :new_syllable }
      end

      context 'for a final' do
        let(:index) { 4 }

        context 'consonant' do
          let(:raw_phones) { %w[P AE1 S IH0 NG] } # passing
          let(:raw_syllables) { [%w[P AE1]] }
          it { is_expected.to be :no_new_syllable }
        end

        context 'vowel preceded by a consonant' do
          let(:raw_phones) { %w[M IH1 L K IY0] } # milky
          let(:raw_syllables) { [%w[M IH1 L]] }
          it { is_expected.to be :no_new_syllable }
        end

        context 'vowel preceded by a consonant that is part of a coda' do
          let(:raw_index) { 3 }
          let(:phones) { %w[CH EH1 R IY0] } # cherry
          it { is_expected.to be :new_syllable }
        end

        context 'vowel preceded by another vowel' do
          let(:raw_phones) { %w[HH AH0 W AY1 IY2] } # Hawaii
          let(:raw_syllables) { [%w[HH AH0]] }
          it { is_expected.to be :new_syllable }
        end

      end

      context 'for a phone preceded by a lower sonority phone that is part of a coda' do
        let(:raw_phones) { %w[IY1 V N IHO NG] } # evening
        let(:index) { 2 }
        it { is_expected.to be :new_syllable }
      end

    end
  end
end
