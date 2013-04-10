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
      sections = phones.chunk {|item| item.syllabic? }.map {|_, section| section }
      if sections.length == 3 || sections.length == 2 && sections[0][0].syllabic?
        sections[-1]
      else
        []
      end
    end

  end
end
