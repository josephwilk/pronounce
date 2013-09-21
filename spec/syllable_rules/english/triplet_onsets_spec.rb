require 'spec_helper'
require 'syllable_rules'
require 'syllable_rules/english'
require 'syllabification_context'

module Pronounce
  describe SyllableRules do
    describe 'triplet onsets' do
      subject do
        context = Pronounce::SyllabificationContext.new syllables, phones, index
        SyllableRules[:en]['triplet onsets'].evaluate context
      end

      let(:syllables) { [] }
      let(:index) { 3 }

      context 'for a voiceless stop or fricative' do
        context 'preceded by /s/ followed by an approximant' do
          let(:phones) { make_phones %w[IH0 K S P L OW1 D] } # explode
          let(:syllables) { [make_syllable(%w[IH0 K])] }
          it { should == false }
        end

        context 'preceded by not /s/' do
          let(:phones) { make_phones %w[L AA1 F K W IH0 S T] } # Lofquist
          it { should == nil }
        end

        context 'followed by not an approximant' do
          let(:phones) { make_phones %w[B EY1 S P N EY0] }
          it { should == nil }
        end

        context 'preceded by /s/ in a coda' do
          let(:phones) { make_phones %w[M IH1 S P R IH1 N T] } # misprint
          it { should == nil }
        end
      end

      context 'for a voiced stop or fricative' do
        let(:phones) { make_phones %w[B EY1 S B L EY0] }
        it { should == nil }
      end

      context 'for an approximant or voiceless affricate' do
        let(:phones) { make_phones %w[B EY1 S CH Y EY0 ] }
        let(:syllables) { [make_syllable(%w[B EY1])] }
        it { should == nil }
      end

      context 'for /s/' do
        context 'followed by a voiceless stop or fricative and an approximant' do
          let(:index) { 1 }
          let(:phones) { make_phones %w[EH0 S P R IY1] } # esprit
          it { should == true }
        end

        context 'followed by a voiceless stop or fricative and not an approximant' do
          let(:phones) { make_phones %w[F AO1 R S T N ER0] } # Forstner
          it { should == nil }
        end

        context 'followed by not a voiceless stop or fricative' do
          let(:phones) { make_phones %w[B EY1 S B L EY0] }
          it { should == nil }
        end
      end

    end
  end
end
