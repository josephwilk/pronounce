require 'pronounce'

module Pronounce
  module Phone
    ARTICULATION_SONORITY = {
      aspirate: 0, # this is a guess
      stop: 1,
      affricate: 2,
      fricative: 3,
      nasal: 4,
      liquid: 5,
      semivowel: 6,
      vowel: 7
    }
    SHORT_VOWELS = %w{AE AH EH IH UH}

    include Comparable

    class << self
      def all
        phones.inject({}) {|all, phone| all.merge phone => phone.articulation }
      end

      def create(symbol)
        ensure_loaded
        Pronounce.const_get(symbol[0..1]).new symbol[2]
      end

      private

      def phones
        @phones ||= parse_phones
      end
      alias ensure_loaded phones

      def parse_phones
        read_data.map {|line| create_phone_class *line.strip.split("\t") }
      end

      def read_data
        File.readlines("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones")
      end

      def create_phone_class(symbol, articulation)
        Pronounce.const_set symbol, Class.new {
          include Phone
          define_singleton_method(:articulation) { articulation.to_sym }
        }
      end

    end

    attr_reader :stress

    def initialize(stress)
      @stress = stress.to_i if stress
    end

    def eql?(phone)
      self.class == phone.class
    end

    def short?
      SHORT_VOWELS.include? symbol
    end

    def syllabic?
      articulation == :vowel
    end

    def to_s
      "#{symbol}#{stress}"
    end

    protected

    def sonority
      ARTICULATION_SONORITY[articulation]
    end

    private

    def <=>(phone)
      self.sonority <=> phone.sonority if Phone === phone
    end

    def articulation
      self.class.articulation
    end

    def symbol
      self.class.name.split('::').last
    end

  end
end
