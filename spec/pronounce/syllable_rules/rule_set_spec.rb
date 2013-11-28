require 'spec_helper'
require 'pronounce/syllable_rules/rule'
require 'pronounce/syllable_rules/rule_set'

module Pronounce::SyllableRules
  describe RuleSet do
    let(:rule_set) { RuleSet.new }

    describe 'rules' do
      let(:rule_name) { 'name' }
      let(:set_name) { :set }
      let(:rule) { Rule.new {} }

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

      it 'returns the first result from an applicable rule' do
        result = :new_syllable
        rule_set.add ['nil'], Rule.new { :not_applicable }
        rule_set.add ['result'], Rule.new { result }
        rule_set.add [:base, 'base'], Rule.new { :no_new_syllable }
        expect(rule_set.evaluate context).to eq result
      end

      it 'returns :not_applicable if no rules apply' do
        rule = Rule.new { nil }
        rule_set.add ['rule'], rule
        expect(rule_set.evaluate context).to be_nil
      end

      it 'calls base rules last' do
        final_rule_called = false
        first_added_rule = Rule.new {}
        first_added_rule.stub(:evaluate) do
          raise if final_rule_called
          :not_applicable
        end
        last_added_rule = Rule.new {}
        last_added_rule.stub(:evaluate) do
          raise if final_rule_called
          :not_applicable
        end
        final_rule = Rule.new {}
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
