require 'spec_helper'
require 'syllable_rules/rule_set'

module Pronounce::SyllableRules
  describe RuleSet do
    let(:rule_set) { RuleSet.new }

    describe 'adding and accessing rules' do
      let(:name) { 'name' }
      let(:rule) { Rule.new proc {|context| } }

      it 'is supported' do
        rule_set[name] = rule
        expect(rule_set[name]).to eq rule
      end
    end

    describe '#evaluate' do
      let(:context) { Object.new }

      it 'returns the first non-nil result from a rule' do
        rule = Rule.new proc {|context| true }
        rule_set['rule'] = rule
        expect(rule_set.evaluate context).to eq true
      end

      it 'returns nil if no rules return a non-nil result' do
        rule = Rule.new proc {|context| nil }
        rule_set['rule'] = rule
        expect(rule_set.evaluate context).to eq nil
      end
    end

  end
end
