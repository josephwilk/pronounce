require 'pronounce/syllable_rules/verbatim_definition'

module Pronounce::SyllableRules
  class RuleEvaluation
    class << self
      def result_for(definition, context)
        new(context).instance_eval &definition
      end

      private :new
    end

    def initialize(context)
      @context = context
    end

    ## DSL ########

    def cannot_match(symbol)
      lambda {|matcher| false if matcher.eql? [Pronounce::Phone.new(symbol)] }
    end

    def onset(predicate)
      return nil if context.current_onset == []
      predicate.call context.current_onset
    end

    def verbatim(&block)
      VerbatimDefinition.new(block).evaluate context
    end

    ## end DSL ####

    private

    attr_reader :context

  end
end
