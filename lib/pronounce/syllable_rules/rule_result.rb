module Pronounce::SyllableRules
  class RuleResult
    include Comparable

    attr_reader :value

    def initialize(name, value)
      @name = name
      @value = value
    end

    def <=>(other)
      return unless RuleResult === other

      compare_by_not_applicable(other.value) ||
      compare_by_base(other.name) ||
      compare_by_value(other.value)
    end

    protected

    attr_reader :name

    private

    def compare_by_not_applicable(other_value)
      if [value, other_value].one? {|v| v == :not_applicable }
        if value == :not_applicable
          -1
        else
          1
        end
      end
    end

    def compare_by_base(other_name)
      if [name, other_name].one? {|n| n == :base }
        if name == :base
          -1
        else
          1
        end
      end
    end

    def compare_by_value(other_value)
      case value
      when other_value
        0
      when :new_syllable
        1
      else
        -1
      end
    end

  end
end
