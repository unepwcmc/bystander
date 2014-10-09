require File.expand_path('../lib/observer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Adam Mulligan", "Andrea Rossi"]
  gem.email         = ["adam.mulligan@unep-wcmc.org", "andrea.rossi@unep-wcmc.org"]
  gem.description   = gem.summary =  "Observe methods and notify through various channels"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test/*`.split("\n")
  gem.name          = "observer"
  gem.require_paths = ["lib"]
  gem.version       = Observer::VERSION

  gem.add_development_dependency 'rake'
end

