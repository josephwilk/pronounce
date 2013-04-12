module Pronounce
  class Syllable
    def initialize(phones)
      @phones = phones
    end

    def as_strings
      phones.map {|phone| phone.to_s }
    end

    def coda_contains?(phone)
      coda.include? phone
    end

    def length
      phones.count
    end

    private

    attr_reader :phones

    def coda
      phones.chunk {|item| item.syllabic? }.
        drop_while {|syllabic, _| !syllabic }.  # drop onset
        collect {|_, section | section }.fetch(1, [])
    end

  end
end
