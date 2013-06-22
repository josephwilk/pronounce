module Pronounce::SyllableRules
  class << self
    def evaluate(context)
      base_rule = -> { rules['sonority sequencing principle'].call context }
      rules[:en].map {|rule| English.send rule, context }.
        find(base_rule) {|result| !result.nil? }
    end

    def rule(name, &block)
      rules[name] = convert_to_lambda &block
    end

    def [](name)
      rules[name]
    end

    private

    # http://www.ruby-forum.com/topic/4407658
    # http://stackoverflow.com/questions/2946603/ruby-convert-proc-to-lambda
    def convert_to_lambda &block
      converted_block = lambda(&block)
      return converted_block if converted_block.lambda?
      obj = Object.new
      obj.define_singleton_method :_, &block
      obj.method(:_).to_proc
    end

    def rules
      @rules ||= {
        en: [:stressed_syllables_heavy, :disallow_ng_onset],
      }
    end

  end

  # Breaks syllables at the low point of sonority between vowels.
  rule 'sonority sequencing principle' do |context|
    return true if context.current_phone.syllabic? && !context.previous_phone_in_onset?
    return false if context.word_end?
    context.previous_phone_in_coda? || context.sonority_trough?
  end

end
