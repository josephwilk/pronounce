require 'spec_helper_methods'
require 'pronounce/syllable'

module Pronounce
  describe Syllable do
    describe '#coda_contains?' do
      let(:syllable) { make_syllable(%w(B R AE1 N D)) } # brand

      it 'is false for part of the onset' do
        expect(syllable.coda_contains? Phone.new('R')).to be false
      end

      it 'is false for the nucleus' do
        expect(syllable.coda_contains? Phone.new('AE1')).to be false
      end

      it 'is true for part of the coda' do
        expect(syllable.coda_contains? Phone.new('D')).to be true
      end
    end

    describe '#has_nucleus?' do
      it 'is false if there is only an onset (pending syllables only)' do
        expect(make_syllable(%w(N)).has_nucleus?).to be false
      end

      it 'is true if there is a nucleus' do
        expect(make_syllable(%w(AE1 D Z)).has_nucleus?).to be true # adz
      end
    end

    it '#length returns the number of phones in the syllable' do
      expect(make_syllable(%w(L AO1 R AH0 L)).length).to be 5 # laurel
    end

    describe '#light?' do
      # communal
      it 'is true if there is a no coda and a short nucleus' do
        expect(make_syllable(%w(K AH0)).light?).to be true
      end

      it 'is false if there is a long nucleus' do
        expect(make_syllable(%w(M Y UW1)).light?).to be false
      end

      it 'is false if there is a nucleus and coda' do
        expect(make_syllable(%w(N AH0 L)).light?).to be false
      end
    end

    describe '#stressed?' do
      # stigma
      it 'is true if the vowel is stressed' do
        expect(make_syllable(%w(S T IH1 G)).stressed?).to be true
      end

      it 'is false if the vowel is unstressed' do
        expect(make_syllable(%w(M AH0)).stressed?).to be false
      end
    end

    it '#to_strings returns an array of strings' do
      expect(make_syllable(%w(AE1 D Z)).to_strings).to eq %w(AE1 D Z) # adz
    end

  end
end
