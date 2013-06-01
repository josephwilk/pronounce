require 'spec_helper'
require 'syllable_rules'

module Pronounce
  describe SyllableRules do
    describe 'rule declaration' do
      let(:name) { 'name' }

      it 'takes a name and a block' do
        SyllableRules.rule name, &proc {|context| true }
        SyllableRules[name].call(nil).should == true
      end
    end

    describe '.evaluate' do
      let(:syllables) { [] }
      let(:phones) { make_phones %w{K AA1 N T EH0 K S T} } # context
      let(:index) { 1 }
      let(:context) { SyllabificationContext.new syllables, phones, index }

      it 'calls the Sonority Sequencing Principle last' do
        final_rule_called = false
        SyllableRules['sonority sequencing principle'].should_receive(:call) do
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
        SyllableRules['sonority sequencing principle'].should_not_receive(:call)
        expect(SyllableRules.evaluate context).to eq true
      end
    end
  end
end
