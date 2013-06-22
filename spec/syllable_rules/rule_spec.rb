require 'spec_helper'
require 'syllable_rules/rule'

module Pronounce::SyllableRules
  describe Rule do
    it 'wraps a proc that takes a context' do
      result = true
      rule = Rule.new proc {|context| context }
      expect(rule.evaluate result).to eq result
    end

    it 'has lambda semantics' do
      result = true
      rule = Rule.new proc {|context| return context }
      expect(rule.evaluate result).to eq result
    end

  end
end
