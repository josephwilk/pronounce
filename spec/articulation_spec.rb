require 'spec_helper'
require 'articulation'

module Pronounce
  describe Articulation do
    it 'does not allow creation of new instances' do
      expect { Articulation.new }.to raise_error NoMethodError
    end

    describe '#<=>' do
      it 'is based on sonority' do
        expect(Articulation[:stop]).to be < Articulation[:fricative]
        expect(Articulation[:affricate]).to be <= Articulation[:fricative]
        expect(Articulation[:fricative]).to eq Articulation[:fricative]
        expect(Articulation[:fricative]).to be >= Articulation[:fricative]
        expect(Articulation[:nasal]).to be > Articulation[:fricative]
      end

      it 'fails when trying to compare to a non-Articulation object' do
        expect { Articulation[:stop] < :fricative }.to raise_error ArgumentError
      end
    end

    describe '#syllabic?' do
      it 'is true for vowels' do
        expect(Articulation[:vowel].syllabic?).to be true
      end

      it 'is false for consonants' do
        expect(Articulation[:affricate].syllabic?).to be false
      end
    end

  end
end
