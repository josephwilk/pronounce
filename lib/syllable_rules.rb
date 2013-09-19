require 'forwardable'
require 'syllable_rules/rule'
require 'syllable_rules/rule_set'

module Pronounce::SyllableRules
  class << self
    extend Forwardable

    def_delegators :rules, :[], :evaluate

    def rule(*path, &block)
      rules.add path, Rule.new(block)
    end

    private

    def rules
      @rules ||= RuleSet.new
    end

  end
end
