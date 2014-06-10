require 'pronounce/phone'
require 'pronounce/syllable'

def make_phones(symbols)
  symbols.map { |symbol| Pronounce::Phone.new(symbol) }
end

def make_syllable(symbols)
  Pronounce::Syllable.new(make_phones(symbols))
end
