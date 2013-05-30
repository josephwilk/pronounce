require 'spec_helper'
require 'syllable_rules'

module Pronounce
  describe SyllableRules do
    describe '.evaluate' do
      let(:syllables) { [] }
      let(:phones) { make_phones %w{K AA1 N T EH0 K S T} } # context
      let(:index) { 1 }
      let(:context) { SyllabificationContext.new syllables, phones, index }

      it 'calls all the rules' do
        SyllableRules::English.should_receive(:stressed_syllables_heavy)
        SyllableRules::English.should_receive(:disallow_ng_onset)
        SyllableRules.should_receive(:sonority_sequencing_principle)
        SyllableRules.evaluate context
      end
    end
  end
end
