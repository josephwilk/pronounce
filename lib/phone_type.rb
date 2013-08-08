require 'articulation'
require 'data_reader'

module Pronounce
  class PhoneType
    SHORT_VOWELS = %w[AE AH EH IH UH]

    include Comparable

    class << self
      def [](name)
        types[name]
      end

      def all
        types.values.each_with_object({}) {|type, all|
          all[type] = type.articulation
        }
      end

      protected :new

      private

      def types
        @types ||= parse_types
      end

      def parse_types
        DataReader.phone_types.each_with_object({}) {|line, types|
          name, articulation = *line.strip.split("\t")
          types[name] = PhoneType.new name, articulation
        }
      end

    end

    attr_reader :articulation, :name

    def initialize(name, articulation)
      @name = name
      @articulation = Articulation[articulation.to_sym]
    end

    def <=>(type)
      self.articulation <=> type.articulation if PhoneType === type
    end

    def inspect
      name
    end

    def short?
      SHORT_VOWELS.include? name
    end

    def syllabic?
      articulation.syllabic?
    end

  end
end
