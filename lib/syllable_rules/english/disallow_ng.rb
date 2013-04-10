module Pronounce::SyllableRules::English
  class DisallowNG
    def self.evaluate(context)
      false if ::Pronounce::NG === context.current_phone
    end

  end
end
