require 'pronounce'
require 'articulation'

module Pronounce
  module Phone
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
        Pronounce.data_reader.phones.map do |line|
          create_phone_class *line.strip.split("\t")
        end
      end

      def create_phone_class(symbol, articulation)
        Pronounce.const_set symbol, Class.new {
          include Phone
          define_singleton_method(:articulation) do
            Articulation[articulation.to_sym]
          end
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
      articulation.syllabic?
    end

    def to_s
      "#{symbol}#{stress}"
    end

    protected

    def articulation
      self.class.articulation
    end

    private

    def <=>(phone)
      self.articulation <=> phone.articulation if Phone === phone
    end

    def symbol
      self.class.name.split('::').last
    end

  end
end
