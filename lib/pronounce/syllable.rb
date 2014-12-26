require 'forwardable'

module Pronounce
  class Syllable
    extend Forwardable

    def_delegator :coda, :include?, :coda_contains?
    def_delegator :phones, :length, :length

    def initialize(phones)
      @phones = phones
    end

    def to_strings
      phones.map { |phone| phone.to_s }
    end

    def light?
      nucleus.all? { |phone| phone.short? } && coda.empty?
    end

    def stressed?
      nucleus.any? { |phone| phone.stress > 0 }
    end

    def has_nucleus?
      !nucleus.empty?
    end

    private

    attr_reader :phones

    def coda
      sections_with_syllabicity
        .drop_while { |syllabic, _| !syllabic } # drop onset
        .map { |_, section| section }.fetch(1, [])
    end

    def nucleus
      sections_with_syllabicity
        .select { |syllabic, _| syllabic }
        .map { |_, section| section }.fetch(0, [])
    end

    def sections_with_syllabicity
      phones.chunk { |item| item.syllabic? }
    end
  end
end
