require 'spec_helper'
require 'syllable_rules/rule'

module Pronounce::SyllableRules
  describe Rule do
    it 'wraps a block with the scope of the parameter to the evaluate method' do
      result = true
      rule = Rule.new { self }
      expect(rule.evaluate result).to eq result
    end

    it 'has lambda semantics for the wrapped block' do
      result = true
      rule = Rule.new { return self }
      expect(rule.evaluate result).to eq result
    end

    it 'evaluation does not leave artifacts on the context' do
      context = Object.new
      original_methods = context.methods
      rule = Rule.new {}
      rule.evaluate context
      expect(context.methods).to eq original_methods
    end

  end
end
