module Pronounce::SyllableRules
  # Breaks syllables at the low point of sonority between vowels.
  class SonoritySequencingPrinciple
    def self.evaluate(word, index)
      return true if word[index].syllabic? && word[index] == word[index - 1]
      return false unless index < word.length - 1
      word[index] < word[index+1] && word[index] <= word[index-1]
    end

  end
end
