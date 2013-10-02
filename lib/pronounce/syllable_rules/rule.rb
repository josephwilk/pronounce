module Pronounce::SyllableRules
  class Rule
    def initialize(&definition)
      @definition = definition
    end

    def evaluate(context)
      context.define_singleton_method :_, &definition
      result = context._
      context.singleton_class.send :remove_method, :_
      result
    end

    private

    attr_reader :definition

  end
end
