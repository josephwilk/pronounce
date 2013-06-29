require 'syllable_rules/rule'
require 'syllable_rules/rule_set'

module Pronounce::SyllableRules
  class << self
    def evaluate(context)
      rules.evaluate context
    end

    def rule(*path, &block)
      rule = Rule.new block
      rules.add path, rule
    end

    def [](name)
      rules[name]
    end

    private

    def rules
      @rules ||= RuleSet.new
    end

  end
end
