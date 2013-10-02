require 'forwardable'
require 'pronounce/articulation'
require 'pronounce/data_reader'

module Pronounce
  class PhoneType
    SHORT_VOWELS = %w[AE AH EH IH UH]

    extend Forwardable
    include Comparable

    class << self
      extend Forwardable

      def_delegators :types, :[]

      private

      def types
        @types ||= parse_types
      end

      def parse_types
        [DataReader.articulations, DataReader.phonations].flatten
          .map {|line| line.strip.split "\t"}
          .group_by {|(name, _)| name}
          .each_with_object({}) {|(name, ((_, manner), (_, phonation))), types|
            types[name] = new(name, manner, phonation)
          }
      end

      private :new

    end

    attr_reader :name

    def_delegators :manner, :syllabic?

    def initialize(name, manner, phonation)
      @name = name
      @manner = Articulation[manner.to_sym]
      @phonation = phonation
    end

    def <=>(type)
      self.manner <=> type.manner if PhoneType === type
    end

    def articulation? *manners
      manners.map {|name| Articulation[name]}.include? manner
    end

    def short?
      SHORT_VOWELS.include? name
    end

    def voiced?
      phonation == 'voiced'
    end

    protected

    attr_reader :manner, :phonation

  end
end
