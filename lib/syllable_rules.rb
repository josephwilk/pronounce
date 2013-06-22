require 'syllable_rules/rule_set'

module Pronounce::SyllableRules
  class << self
    def evaluate(context)
      if (result = rules[:en].call context).nil?
        rules['Sonority Sequencing Principle'].call context
      else
        result
      end
    end

    def rule(*path, &block)
      rule = convert_to_lambda &block
      if path.length > 1
        add_nested_rule(path, rule)
      else
        rules[path[0]] = rule
      end
    end

    def [](name)
      rules[name]
    end

    private

    def add_nested_rule(path, rule)
      set_name = path.shift
      rules[set_name] = RuleSet.new unless rules.has_key? set_name
      rules[set_name][path[0]] = rule
    end

    def convert_to_lambda(&block)
      if (converted_block = lambda(&block)).lambda?
        converted_block
      else
        mri_convert_to_lambda(&block)
      end
    end

    # http://www.ruby-forum.com/topic/4407658
    # http://stackoverflow.com/questions/2946603/ruby-convert-proc-to-lambda
    def mri_convert_to_lambda(&block)
      obj = Object.new
      obj.define_singleton_method :_, &block
      obj.method(:_).to_proc
    end

    def rules
      @rules ||= {}
    end

  end

  # Breaks syllables at the low point of sonority between vowels.
  rule 'Sonority Sequencing Principle' do |context|
    return true if context.current_phone.syllabic? && !context.previous_phone_in_onset?
    return false if context.word_end?
    context.previous_phone_in_coda? || context.sonority_trough?
  end

  require 'syllable_rules/english'

end
