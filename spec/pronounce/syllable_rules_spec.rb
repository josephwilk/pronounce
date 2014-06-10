require 'spec_helper'
require 'pronounce/syllable_rules'

module Pronounce
  describe SyllableRules do
    describe 'rule declaration' do
      let(:rule_name) { 'name' }
      let(:set_name) { :set }

      it 'takes a name and a block' do
        result = :new_syllable
        SyllableRules.rule(rule_name) { result }
        expect(SyllableRules[rule_name].evaluate(nil)).to eq result

        # clean up
        SyllableRules.rule(rule_name) { :not_applicable }
      end

      it 'can take an arbitrary length path' do
        result = :new_syllable
        SyllableRules.rule(set_name, rule_name) { result }
        expect(SyllableRules[set_name][rule_name].evaluate(nil)).to eq result

        # clean up
        SyllableRules.rule(set_name, rule_name) { :not_applicable }
      end
    end

  end
end
