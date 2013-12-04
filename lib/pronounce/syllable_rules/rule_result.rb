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

      compare_by(:not_applicable, value, other.value) ||
      compare_by(:base, name, other.name) ||
      compare_by_value(other.value)
    end

    protected

    attr_reader :name

    private

    def compare_by(lower_value, attribute, other_attribute)
      if [attribute, other_attribute].one? {|a| a == lower_value }
        if attribute == lower_value
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
