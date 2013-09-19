require 'forwardable'

module Pronounce::SyllableRules
  class Rule
    extend Forwardable

    def_delegator :definition, :call, :evaluate

    def initialize(definition)
      @definition = convert_to_lambda definition
    end

    private

    attr_reader :definition

    def convert_to_lambda(definition)
      if (converted_proc = lambda &definition).lambda?
        converted_proc
      else
        mri_convert_to_lambda definition
      end
    end

    # http://www.ruby-forum.com/topic/4407658
    # http://stackoverflow.com/questions/2946603/ruby-convert-proc-to-lambda
    def mri_convert_to_lambda(definition)
      obj = Object.new
      obj.define_singleton_method :_, &definition
      obj.method(:_).to_proc
    end

  end
end
