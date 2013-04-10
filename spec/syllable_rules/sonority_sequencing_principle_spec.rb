require 'spec_helper'

module Pronounce::SyllableRules
  describe SonoritySequencingPrinciple do
    subject do
      context = Pronounce::SyllabificationContext.new syllables, phones, index
      SonoritySequencingPrinciple.evaluate context
    end

    let(:syllables) { [] }
    let(:phones) { make_phones 'OW', 'AA', 'NG', 'T', 'R', 'UW', 'F' }

    context 'for a vowel preceded by another vowel' do
      let(:index) { 1 }
      it { should == true }
    end

    context 'for a consonant followed by a lower sonority phone' do
      let(:syllables) { [make_syllable('OW')] }
      let(:index) { 2 }
      it { should == false }
    end

    context 'for a sonority trough' do
      let(:syllables) { [make_syllable('OW')] }
      let(:index) { 3 }
      it { should == true }
    end

    context 'for a phone preceded by a lower sonority phone' do
      let(:syllables) { [make_syllable('OW'), make_syllable('AA', 'NG')] }
      let(:index) { 4 }
      it { should == false }
    end

    context 'for a sonority peak' do
      let(:syllables) { [make_syllable('OW'), make_syllable('AA', 'NG')] }
      let(:index) { 5 }
      it { should == false }
    end

    context 'for a consonant preceded by another consonant of equal sonority' do
      let(:phones) { make_phones 'Y', 'UW1', 'S', 'F', 'AH0', 'L' } # useful
      let(:index) { 3 }
      it { should == true }
    end

    context 'for a final' do
      let(:index) { 4 }

      context 'consonant' do
        let(:phones) { make_phones 'P', 'AE1', 'S', 'IH0', 'NG' } # passing
        let(:syllables) { [make_syllable('P', 'AE1')] }
        it { should == false }
      end

      context 'vowel preceded by a consonant' do
        let(:phones) { make_phones 'M', 'IH1', 'L', 'K', 'IY0' } # milky
        let(:syllables) { [make_syllable('M', 'IH1', 'L')] }
        it { should == false }
      end

      context 'vowel preceded by another vowel' do
        let(:phones) { make_phones 'HH', 'AH0', 'W', 'AY1', 'IY2' } # Hawaii
        let(:syllables) { [make_syllable('HH', 'AH0')] }
        it { should == true }
      end

    end

    context 'for a phone preceded by a lower sonority phone that is part of a coda' do
      let(:phones) { make_phones 'IY1', 'V', 'N', 'IHO', 'NG' } # evening
      let(:index) { 2 }
      it { should == true }
    end

  end
end
