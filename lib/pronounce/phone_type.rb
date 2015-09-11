require 'forwardable'
require 'pronounce/articulation'
require 'pronounce/data_reader'

module Pronounce
  class PhoneType
    SHORT_VOWELS = %w(AE AH EH IH UH)

    extend Forwardable
    include Comparable

    class << self
      def [](name)
        if types.key? name
          types[name]
        else
          fail ArgumentError, 'invalid name'
        end
      end

      private

      def types
        @types ||= build_types
      end

      def build_types
        DataReader.articulations.merge(DataReader.phonations) { |name, manner, phonation|
          new(name, manner, phonation)
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

    def <=>(other)
      manner <=> other.manner if other.is_a? PhoneType
    end

    def articulation?(*manners)
      manners.map { |name| Articulation[name] }.include? manner
    end

    def short?
      SHORT_VOWELS.include? name
    end

    def voiced?
      phonation == 'voiced'
    end

    def voiceless?
      !voiced?
    end

    protected

    attr_reader :manner, :phonation
  end
end
