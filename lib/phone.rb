module Pronounce
  class Phone
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
        phones = []
        read_data.each do |line|
          phones << create_phone_type(*line.strip.split("\t"))
        end
        phones
      end

      def read_data
        File.readlines("#{DATA_DIR}/cmudict/cmudict.#{CMUDICT_VERSION}.phones")
      end

      def create_phone_type(symbol, articulation)
        phone = Pronounce.const_set(symbol, Class.new(Phone))
        phone.class_eval <<-END
          class << self
            def articulation
              '#{articulation}'
            end

            def sonority
              #{sonority_of articulation}
            end
          end

          def syllabic?
            #{articulation == 'vowel'}
          end
        END
        phone
      end

      def sonority_of(articulation)
        @sonority ||= {
          'aspirate' => 0, # this is a guess
          'stop' => 1,
          'affricate' => 2,
          'fricative' => 3,
          'nasal' => 4,
          'liquid' => 5,
          'semivowel' => 6,
          'vowel' => 7
        }
        @sonority[articulation]
      end

    end

    def initialize(stress)
      @stress = stress
    end

    def to_s
      "#{self.class.name.split('::').last}#{@stress}"
    end

    private

    def <=>(phone)
      phone.is_a?(Phone) ? self.class.sonority <=> phone.class.sonority : nil
    end

  end
end
