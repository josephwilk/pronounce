require 'spec_helper'
require 'pronounce/syllabification_context'
require 'pronounce/syllable_rules'
require 'pronounce/syllable_rules/english'

module Pronounce
  describe SyllableRules do
    describe '/s/ cluster onsets' do
      subject do
        context = Pronounce::SyllabificationContext.new syllables, phones, index
        SyllableRules[:en]['/s/ cluster onsets'].evaluate context
      end

      let(:syllables) { [] }
      let(:index) { 3 }

      context 'for a voiceless stop or fricative' do
        context 'followed by an approximant preceded by /s/' do
          let(:phones) { make_phones %w[EH2 K S P L AH0 N EY1 SH AH0 N] } # explanation
          let(:syllables) { [make_syllable(%w[EH2 K])] }
          it { is_expected.to be :no_new_syllable }
        end

        context 'followed by a vowel preceded by /s/' do
          let(:phones) { make_phones %w[IH0 K S P OW1 Z] } # expose
          let(:syllables) { [make_syllable(%w[IH0 K])] }
          it { is_expected.to be :no_new_syllable }
        end

        context 'followed by an approximant preceded by not /s/' do
          let(:phones) { make_phones %w[L AA1 F K W IH0 S T] } # Lofquist
          it { is_expected.to be :not_applicable }
        end

        context 'followed by a vowel preceded by not /s/' do
          let(:phones) { make_phones %w[K AA1 F K AH0] } # Kafka
          it { is_expected.to be :not_applicable }
        end

        context "followed by a consonant that's not an approximant" do
          let(:phones) { make_phones %w[B EY1 S P N EY0] }
          it { is_expected.to be :not_applicable }
        end

        context 'followed by an approximant preceded by /s/ in a coda' do
          let(:phones) { make_phones %w[M IH1 S P R IH1 N T] } # misprint
          it { is_expected.to be :not_applicable }
        end

        context 'followed by a vowel preceded by /s/ in a coda' do
          let(:phones) { make_phones %w[M IH1 S F IH2 T] } # misfit
          it { is_expected.to be :not_applicable }
        end

        context 'at a word end' do
          let(:phones) { make_phones %w[F ER1 S T] }
          it { is_expected.to be :not_applicable }
        end
      end

      context 'for a voiced stop or fricative' do
        context 'followed by an approximant' do
          let(:phones) { make_phones %w[B EY1 S B L EY0] }
          let(:syllables) { [make_syllable(%w[B EY1])] }
          it { is_expected.to be :not_applicable }
        end

        context 'followed by a vowel' do
          let(:phones) { make_phones %w[M IH0 S G IH1 V] } # misgive
          it { is_expected.to be :not_applicable }
        end
      end

      context 'for a voiceless not stop or fricative' do
        let(:phones) { make_phones %w[B EY1 S CH Y EY0 ] }
        let(:syllables) { [make_syllable(%w[B EY1])] }
        it { is_expected.to be :not_applicable }
      end

      context 'for /s/' do
        context 'followed by a voiceless stop or fricative and an approximant' do
          let(:index) { 1 }
          let(:phones) { make_phones %w[EH0 S P R IY1] } # esprit
          it { is_expected.to be :new_syllable }
        end

        context 'followed by a voiceless stop or fricative and a vowel' do
          let(:index) { 0 }
          let(:phones) { make_phones %w[S K AE1 R K R OW0] } # scarecrow
          it { is_expected.to be :new_syllable }
        end

        context "followed by a voiceless stop or fricative and a consonant that's not an approximant" do
          let(:phones) { make_phones %w[F AO1 R S T N ER0] } # Forstner
          it { is_expected.to be :not_applicable }
        end

        context 'followed by not a voiceless stop or fricative' do
          let(:index) { 2 }
          let(:phones) { make_phones %w[B EY1 S B L EY0] }
          it { is_expected.to be :not_applicable }
        end

        context 'starting a cluster at a word end' do
          let(:index) { 2 }
          let(:phones) { make_phones %w[F ER1 S T] }
          it { is_expected.to be :not_applicable }
        end
      end

    end
  end
end
