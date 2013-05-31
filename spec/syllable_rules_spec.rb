require 'spec_helper'
require 'syllable_rules'

module Pronounce
  describe SyllableRules do
    describe 'rule declaration' do
      let(:name) { 'name' }
      let(:block) { -> {} }

      it 'takes a name and a block' do
        block.should_receive(:call)
        SyllableRules.rule name, &block
        SyllableRules[name].call
      end
    end

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

      it 'calls the Sonority Sequencing Principle last' do
        final_rule_called = false
        SyllableRules.should_receive(:sonority_sequencing_principle) do
          final_rule_called = true
        end
        SyllableRules::English.should_receive(:stressed_syllables_heavy) do
          raise if final_rule_called
        end
        SyllableRules::English.should_receive(:disallow_ng_onset) do
          raise if final_rule_called
        end
        SyllableRules.evaluate context
      end

      it 'returns the first boolean value returned by a rule' do
        SyllableRules::English.should_receive(:stressed_syllables_heavy)
        SyllableRules::English.should_receive(:disallow_ng_onset).and_return(true)
        SyllableRules.should_not_receive(:sonority_sequencing_principle)
        expect(SyllableRules.evaluate context).to eq true
      end
    end
  end
end
