require 'pronounce/syllable_rules/rule_evaluation'

module Pronounce::SyllableRules
  class Rule
    def initialize(&definition)
      @definition = definition
    end

    def evaluate(context)
      RuleEvaluation.result(definition, context)
    end

    private

    attr_reader :definition

  end
end
