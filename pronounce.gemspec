Gem::Specification.new do |s|
  s.name        = "pronounce"
  s.version     = "0.0.1"
  s.authors     = ["Joseph Wilk"]
  s.email       = ["joe@josephwilk.net"]
  s.homepage    = "http://github.com/josephwilk/pronounce"
  s.summary     = "Helping provide useful information about words for machines"
  s.description = "Helping provide useful information about words for machines"
  s.add_development_dependency 'rake'
  s.files        = Dir.glob("{lib}/**/*") + Dir.glob("{data}/**/*")  + %w(README.md)
  s.require_path = 'lib'
end
