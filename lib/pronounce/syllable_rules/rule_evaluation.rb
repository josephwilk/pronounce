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
      convert_to_lambda(block).call context
    end

    ## end DSL ####

    private

    attr_reader :context

    def convert_to_lambda(block)
      if (converted_block = lambda &block).lambda?
        converted_block
      else
        mri_convert_to_lambda block
      end
    end

    # http://www.ruby-forum.com/topic/4407658
    # http://stackoverflow.com/questions/2946603/ruby-convert-proc-to-lambda
    def mri_convert_to_lambda(block)
      obj = Object.new
      obj.define_singleton_method :_, &block
      obj.method(:_).to_proc
    end

  end
end
