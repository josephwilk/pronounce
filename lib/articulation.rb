module Pronounce
  class Articulation
    include Comparable

    def initialize(name, sonority)
      @name = name
      @sonority = sonority
    end

    class << self
      NAMED_ARTICULATIONS = {
        aspirate:  Articulation.new(:aspirate, 0), # Dogil 1992, p393
        stop:      Articulation.new(:stop, 1),
        affricate: Articulation.new(:affricate, 2),
        fricative: Articulation.new(:fricative, 3),
        nasal:     Articulation.new(:nasal, 4),
        liquid:    Articulation.new(:liquid, 5),
        semivowel: Articulation.new(:semivowel, 6),
        vowel:     Articulation.new(:vowel, 7)
      }

      def [](name)
        NAMED_ARTICULATIONS[name]
      end

      protected :new

    end

    def <=>(other)
      sonority <=> other.sonority if Articulation === other
    end

    def inspect
      name.to_s
    end

    def syllabic?
      sonority == 7
    end

    protected

    attr_reader :sonority

    private

    attr_reader :name

  end
end
