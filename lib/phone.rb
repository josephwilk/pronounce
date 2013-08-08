require 'phone_type'

module Pronounce
  class Phone
    include Comparable

    attr_reader :stress

    def initialize(symbol)
      @type = PhoneType[symbol[0..1]]
      raise ArgumentError.new('invalid symbol') unless @type
      @stress = symbol[2].to_i if symbol.length == 3
    end

    def <=>(other)
      type <=> other.type if Phone === other
    end

    def eql?(other)
      return false unless Phone === other
      type.eql? other.type
    end

    def hash
      "#{self.class}:#{type.name}".hash
    end

    def short?
      type.short?
    end

    def syllabic?
      type.syllabic?
    end

    def to_s
      "#{type.name}#{stress}"
    end

    protected

    attr_reader :type

  end
end
