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
        expect(SyllableRules[rule_name].evaluate nil).to eq result

        # clean up
        SyllableRules.rule(rule_name) {|context| nil }
      end

      it 'can take an arbitrary length path' do
        result = true
        SyllableRules.rule(set_name, rule_name) {|context| result }
        expect(SyllableRules[set_name][rule_name].evaluate nil).to eq result

        # clean up
        SyllableRules.rule(set_name, rule_name) {|context| nil }
      end
    end

  end
end
