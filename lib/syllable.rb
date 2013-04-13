module Pronounce
  class Syllable
    def initialize(phones)
      @phones = phones
    end

    def to_strings
      phones.map {|phone| phone.to_s }
    end

    def coda_contains?(phone)
      coda.include? phone
    end

    def length
      phones.count
    end

    def light?
      nucleus.all? {|phone| phone.short? } && coda.empty?
    end

    def stressed?
      nucleus.any? {|phone| phone.stress > 0 }
    end

    private

    attr_reader :phones

    def coda
      phones.chunk {|item| item.syllabic? }.
        drop_while {|syllabic, _| !syllabic }. # drop onset
        collect {|_, section | section }.fetch(1, [])
    end

    def nucleus
      phones.chunk {|item| item.syllabic? }.
        find {|syllabic, _| syllabic }.fetch(1, [])
    end

  end
end
