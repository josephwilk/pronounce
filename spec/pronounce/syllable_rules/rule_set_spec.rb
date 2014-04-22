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
        rule_set.add([rule_name], rule)
        expect(rule_set[rule_name]).to be rule
      end

      it 'added with a path create nested rule sets' do
        rule_set.add([set_name, rule_name], rule)
        expect(rule_set[set_name][rule_name]).to be rule
      end
    end

    describe '#evaluate' do
      let(:context) { Object.new }

      it 'returns the greatest result' do
        result = :no_new_syllable
        rule_set.add([:lang, 'NA'], Rule.new { :not_applicable })
        rule_set.add([:lang, 'highest'], Rule.new { result })
        rule_set.add([:base, 'base'], Rule.new { :new_syllable })
        expect(rule_set.evaluate(context)).to eq result
      end
    end

  end
end
