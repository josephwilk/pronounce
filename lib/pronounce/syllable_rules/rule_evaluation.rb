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

    ## DSL #############

    def verbatim(&block)
      VerbatimDefinition.new(block).evaluate context
    end

    #### subjects ######

    def onset(predicate)
      return :not_applicable if context.current_onset == []
      predicate.call context.current_onset
    end

    def syllable(predicate)
      predicate.call context.pending_syllable
    end

    #### predicates ####

    def cannot_be(*objects)
      lambda {|subject|
        if interogative_method_names(objects).all? {|method_name|
          subject.send method_name
        }
          :no_new_syllable 
        else
          :not_applicable
        end
      }
    end

    def cannot_match(object)
      lambda {|subject|
        if subject.eql? [Pronounce::Phone.new(object)]
          :no_new_syllable
        else
          :not_applicable
        end
      }
    end

    ## end DSL #########

    private

    attr_reader :context

    def interogative_method_names(interogatives)
      interogatives.map {|interogative| "#{interogative}?" }
    end

  end
end
