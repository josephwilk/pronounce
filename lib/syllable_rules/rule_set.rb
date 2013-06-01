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

    def call(context)
      @rules.lazy.map {|_, rule| rule.call context }.find {|result| !result.nil? }
    end

  end
end
