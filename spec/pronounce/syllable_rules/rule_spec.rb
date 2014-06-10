require 'spec_helper'
require 'pronounce/syllable_rules/rule'

module Pronounce::SyllableRules
  describe Rule do
    it 'wraps a block that is executed by the evaluate method' do
      result = true
      expect(Rule.new { result }.evaluate(nil)).to eq result
    end

    it 'supports the rule DSL in the wrapped block' do
      result = true
      rule = Rule.new { verbatim {|context| context } }
      expect(rule.evaluate(result)).to eq result
    end

  end
end
