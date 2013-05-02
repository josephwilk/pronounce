# encoding: UTF-8

module Pronounce::SyllableRules::English
  class DisallowNGOnset
    # /Ŋ/ cannot start a syllable.
    def self.evaluate(context)
      false if ::Pronounce::NG === context.current_phone
    end

  end
end
