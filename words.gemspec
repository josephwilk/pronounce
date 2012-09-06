Gem::Specification.new do |s|
  s.name        = "words"
  s.version     = "0.0.1"
  s.authors     = ["Joseph Wilk"]
  s.email       = ["joe@josephwilk.net"]
  s.homepage    = "http://github.com/josephwilk/words"
  s.summary     = "Dictionary lookups for finding out information about English words"
  s.description = "Helping provide useful information about words for machines"
  s.add_development_dependency "rspec"
  s.files        = Dir.glob("{lib}/**/*") + Dir.glob("{data}/**/*")  + %w(README.md)
  s.require_path = 'lib'
end
