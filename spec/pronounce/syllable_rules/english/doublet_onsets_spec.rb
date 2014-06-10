require 'spec_helper_methods'
require 'pronounce/syllabification_context'
require 'pronounce/syllable_rules'
require 'pronounce/syllable_rules/english'

module Pronounce
  describe SyllableRules do
    describe 'doublet onsets' do
      subject do
        phones = make_phones(raw_phones)
        context = Pronounce::SyllabificationContext.new(syllables, phones, index)
        SyllableRules[:en]['doublet onsets'].evaluate(context)
      end

      let(:syllables) { [] }
      let(:index) { 1 }

      context 'for a stop or voiceless fricative' do
        context 'followed by an approximant other than /j/' do
          let(:raw_phones) { %w[D R AY1 K L IY2 N] } # dryclean
          let(:index) { 3 }
          it { is_expected.to be :not_applicable }
        end

        context 'followed by /j/' do
          let(:raw_phones) { %w[P R AH0 F Y UW1 S L IY0] } # profusely
          let(:index) { 3 }
          it { is_expected.to be :not_applicable }
        end

        context "followed by a consonant that's not an approximant" do
          let(:raw_phones) { %w[EH0 TH N IH1 S IH0 T IY0] } # ethnicity
          it { is_expected.to be :no_new_syllable }
        end
      end

      context 'for a voiced fricative or not stop or fricative' do
        context 'followed by an approximant other than /j/' do
          let(:raw_phones) { %w[AA1 M W AA0 R] } # armoire
          it { is_expected.to be :no_new_syllable }
        end

        context 'followed by /j/' do
          let(:raw_phones) { %w[M AO1 JH Y UW0 L EY0 T] } # modulate
          let(:index) { 2 }
          it { is_expected.to be :not_applicable }
        end

        context "followed by a consonant that's not an approximant" do
          let(:raw_phones) { %w[AE0 Z M AE1 T IH0 K] } # asthmatic
          it { is_expected.to be :no_new_syllable }
        end
      end

    end
  end
end
