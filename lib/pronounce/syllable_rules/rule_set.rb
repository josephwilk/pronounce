require 'forwardable'
require 'pronounce/syllable_rules/rule_result'

module Pronounce::SyllableRules
  class RuleSet
    extend Forwardable

    def_delegators :rules, :[]

    def initialize
      @rules = {}
    end

    def add(path, rule)
      name, *nested_path = path
      if nested_path.any?
        rules[name] = RuleSet.new unless rules.has_key? name
        rules[name].add nested_path, rule
      else
        rules[name] = rule
      end
    end

    def evaluate(context)
      rules.map {|key, rule| RuleResult.new(key, rule.evaluate(context)) }.max.value
    end

    private

    attr_reader :rules

  end
end
