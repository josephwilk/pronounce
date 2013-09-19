require 'spec_helper'
require 'syllable_rules/rule'
require 'syllable_rules/rule_set'

module Pronounce::SyllableRules
  describe RuleSet do
    let(:rule_set) { RuleSet.new }

    describe 'rules' do
      let(:rule_name) { 'name' }
      let(:set_name) { :set }
      let(:rule) { Rule.new proc {|context| } }

      it 'can be added and accessed' do
        rule_set.add [rule_name], rule
        expect(rule_set[rule_name]).to be rule
      end

      it 'added with a path create nested rule sets' do
        rule_set.add [set_name, rule_name], rule
        expect(rule_set[set_name][rule_name]).to be rule
      end
    end

    describe '#evaluate' do
      let(:context) { Object.new }

      it 'returns the first non-nil result from a rule' do
        result = true
        rule_set.add ['nil'], Rule.new(proc {|context| })
        rule_set.add ['result'], Rule.new(proc {|context| result })
        rule_set.add [:base, 'base'], Rule.new(proc {|context| false })
        expect(rule_set.evaluate context).to eq result
      end

      it 'returns nil if no rules return a non-nil result' do
        rule = Rule.new proc {|context| nil }
        rule_set.add ['rule'], rule
        expect(rule_set.evaluate context).to be_nil
      end

      it 'calls base rules last' do
        final_rule_called = false
        first_added_rule = Rule.new proc {|context| }
        first_added_rule.stub(:evaluate) { raise if final_rule_called }
        last_added_rule = Rule.new proc {|context| }
        last_added_rule.stub(:evaluate) { raise if final_rule_called }
        final_rule = Rule.new proc {|context| }
        final_rule.stub(:evaluate) { final_rule_called = true }
        rule_set.add [:set_1, 'first added'], first_added_rule
        rule_set.add [:base, 'final rule'], final_rule
        rule_set.add [:set_2, 'last added'], last_added_rule
        rule_set.evaluate context
        expect(first_added_rule).to have_received :evaluate
        expect(last_added_rule).to have_received :evaluate
        expect(final_rule).to have_received :evaluate
      end
    end

  end
end
