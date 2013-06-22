require 'spec_helper'
require 'syllable_rules'

module Pronounce
  describe SyllableRules do
    describe 'rule declaration' do
      let(:rule_name) { 'name' }
      let(:set_name) { :set }

      it 'takes a name and a block' do
        result = true
        SyllableRules.rule(rule_name) {|context| result }
        expect(SyllableRules[rule_name].call nil).to eq result
      end

      it 'can take a path that creates rule sets' do
        result = true
        SyllableRules.rule(set_name, rule_name) {|context| result }
        expect(SyllableRules[set_name][rule_name].call nil).to eq result
      end
    end

    describe '.evaluate' do
      let(:syllables) { [] }
      let(:phones) { make_phones %w{K AA1 N T EH0 K S T} } # context
      let(:index) { 1 }
      let(:context) { SyllabificationContext.new syllables, phones, index }

      it 'calls the Sonority Sequencing Principle last' do
        final_rule_called = false
        SyllableRules['Sonority Sequencing Principle'].should_receive :call do
          final_rule_called = true
        end
        SyllableRules[:en]['stressed syllables cannot be light'].should_receive :call do
          raise if final_rule_called
        end
        SyllableRules[:en]['/ng/ cannot start a syllable'].should_receive :call do
          raise if final_rule_called
        end
        SyllableRules.evaluate context
      end

      it 'returns the first boolean value returned by a rule' do
        SyllableRules[:en]['stressed syllables cannot be light'].should_receive :call
        SyllableRules[:en]['/ng/ cannot start a syllable'].should_receive(:call).and_return true
        SyllableRules['Sonority Sequencing Principle'].should_not_receive :call
        expect(SyllableRules.evaluate context).to eq true
      end
    end
  end
end
