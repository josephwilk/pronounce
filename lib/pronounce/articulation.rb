require 'forwardable'

module Pronounce
  class Articulation
    include Comparable

    def initialize(sonority)
      @sonority = sonority
    end

    class << self
      ARTICULATIONS = {
        aspirate:  Articulation.new(0), # Dogil 1992, p393
        stop:      Articulation.new(1),
        affricate: Articulation.new(2),
        fricative: Articulation.new(3),
        nasal:     Articulation.new(4),
        liquid:    Articulation.new(5),
        semivowel: Articulation.new(6),
        vowel:     Articulation.new(7)
      }

      extend Forwardable

      def_delegators :ARTICULATIONS, :[]

      private :new

    end

    def <=>(other)
      sonority <=> other.sonority if Articulation === other
    end

    def syllabic?
      sonority == 7
    end

    protected

    attr_reader :sonority

  end
end
