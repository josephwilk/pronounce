module Pronounce::SyllableRules
  class RuleSet
    def initialize
      @rules = {}
    end

    def []=(name, rule)
      @rules[name] = rule
    end

    def [](name)
      @rules[name]
    end

    def evaluate(context)
      @rules.map {|_, rule| rule.evaluate context }.find {|result| !result.nil? }
    end

  end
end
