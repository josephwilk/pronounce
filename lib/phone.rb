require_relative 'pronounce'

module Pronounce
  class Phone
    include Comparable

    class << self
      def all
        phones.values
      end

      def find(symbol)
        phones[symbol[0..1]]
      end

      private

      def phones
        @phones ||= parse_phones
      end

      def parse_phones
        phones = {}
        read_data.each do |line|
          symbol, articulation = *line.strip.split("\t")
          phones[symbol] = Phone.new(symbol, articulation)
        end
        phones
      end

      def read_data
        File.readlines("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones")
      end

    end

    def <=>(phone)
      self.class == phone.class ? @sonority <=> phone.sonority : nil
    end

    def eql?(phone)
      self.class == phone.class && @symbol == phone.symbol
    end
    alias == eql?

    def hash
      @symbol.hash
    end

    def to_s
      "#{@symbol} (#{@articulation})"
    end

    protected

    attr_reader :sonority, :symbol

    private

    def initialize(symbol, articulation)
      @@sonorance ||= {
        'aspirate' => 0, # this is a guess
        'stop' => 1,
        'affricate' => 2,
        'fricative' => 3,
        'nasal' => 4,
        'liquid' => 5,
        'semivowel' => 6,
        'vowel' => 7
      }

      @symbol = symbol
      @articulation = articulation
      @sonority = @@sonorance[@articulation]
    end

  end
end
