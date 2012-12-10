require 'spec_helper'

module Pronounce::SyllableRules
  describe SonoritySequencingPrinciple do
    let(:test_word) { build_word ['OW', 'AA', 'NG', 'T', 'R', 'UW', 'F'] }
    let(:consonant_consonant) { build_word ['Y', 'UW1', 'S', 'F', 'AH0', 'L'] }
    let(:final_vowel_vowel) { build_word ['HH', 'AH0', 'W', 'AY1', 'IY2'] }
    let(:final_consonant_vowel) { build_word ['AH0', 'G', 'L', 'OW1'] }

    describe 'identifies as a syllable' do
      it 'a vowel following another vowel' do
        SonoritySequencingPrinciple.evaluate(test_word, 1).should be_true
      end

      it 'a final vowel following another vowel' do
        SonoritySequencingPrinciple.evaluate(final_vowel_vowel, 4).should be_true
      end

      it 'a consonant followed by another consonant of equal sonority' do
        SonoritySequencingPrinciple.evaluate(consonant_consonant, 3).should be_true
      end

      it 'a sonority trough' do
        SonoritySequencingPrinciple.evaluate(test_word, 3).should be_true
      end
    end

    describe 'identifies as not a syllable' do
      it 'a sonority peak' do
        SonoritySequencingPrinciple.evaluate(test_word, 5).should be_false
      end

      it 'a phone followed by a lower sonority phone' do
        SonoritySequencingPrinciple.evaluate(test_word, 2).should be_false
      end

      it 'a phone preceded by a lower sonority phone' do
        SonoritySequencingPrinciple.evaluate(test_word, 4).should be_false
      end

      it 'a final consonant' do
        SonoritySequencingPrinciple.evaluate(test_word, 6).should be_false
      end

      it 'a final vowel following a consonant' do
        SonoritySequencingPrinciple.evaluate(final_consonant_vowel, 3).should be_false
      end
    end

  end
end
