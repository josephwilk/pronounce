require 'pronounce/syllable_rules/verbatim_definition'

module Pronounce::SyllableRules
  class RuleEvaluation
    class << self
      def result(definition, context)
        new(context).instance_eval &definition
      end

      private :new
    end

    def initialize(context)
      @context = context
    end

    ## DSL ########

    def verbatim(&block)
      VerbatimDefinition.new(block).evaluate context
    end

    ## end DSL ####

    private

    attr_reader :context

  end
end
