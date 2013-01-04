require 'spec_helper'

module Pronounce::SyllableRules
  describe SonoritySequencingPrinciple do
    subject do
      context = Pronounce::SyllabificationContext.new word, index
      SonoritySequencingPrinciple.evaluate context
    end

    let(:word) { build_word 'OW', 'AA', 'NG', 'T', 'R', 'UW', 'F' }

    context 'for a vowel preceded by another vowel' do
      let(:index) { 1 }
      it { should == true }
    end

    context 'for a consonant followed by a lower sonority phone' do
      let(:index) { 2 }
      it { should == false }
    end

    context 'for a sonority trough' do
      let(:index) { 3 }
      it { should == true }
    end

    context 'for a phone preceded by a lower sonority phone' do
      let(:index) { 4 }
      it { should == false }
    end

    context 'for a sonority peak' do
      let(:index) { 5 }
      it { should == false }
    end

    context 'for a consonant preceded by another consonant of equal sonority' do
      let(:word) { build_word 'Y', 'UW1', 'S', 'F', 'AH0', 'L' } # useful
      let(:index) { 3 }
      it { should == true }
    end

    context 'for a final' do
      let(:index) { 4 }

      context 'consonant' do
        let(:word) { build_word 'P', 'AE1', 'S', 'IH0', 'NG' } # passing
        it { should == false }
      end

      context 'vowel preceded by a consonant' do
        let(:word) { build_word 'M', 'IH1', 'L', 'K', 'IY0' } # milky
        it { should == false }
      end

      context 'vowel preceded by another vowel' do
        let(:word) { build_word 'HH', 'AH0', 'W', 'AY1', 'IY2' } # Hawaii
        it { should == true }
      end

    end

  end
end
