module Pronounce
  class SyllabificationContext
    def initialize(word, index)
      @word = word
      @index = index
    end

    def current_phone
      @word[@index]
    end

    def next_phone
      @word[@index + 1] unless word_end?
    end

    def previous_phone
      @word[@index - 1] unless word_beginning?
    end

    def word_beginning?
      @index == 0
    end

    def word_end?
      @index == @word.length - 1
    end

  end
end
