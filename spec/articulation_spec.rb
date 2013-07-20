require 'spec_helper'
require 'articulation'

module Pronounce
  describe Articulation do
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

    describe 'inspect' do
      it 'returns the name only' do
        expect(Articulation[:vowel].inspect).to eq 'vowel'
      end
    end
  end
end
