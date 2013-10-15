require 'forwardable'

module Pronounce::SyllableRules
  class VerbatimDefinition
    extend Forwardable

    def_delegator :definition, :call, :evaluate

    def initialize(definition)
      @definition = convert_to_lambda definition
    end

    private

    attr_reader :definition

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
