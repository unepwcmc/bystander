require File.expand_path('../lib/bystander/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Adam Mulligan", "Andrea Rossi"]
  gem.email         = ["adam.mulligan@unep-wcmc.org", "andrea.rossi@unep-wcmc.org"]
  gem.description   = gem.summary =  "Log your application flow without any ugly loggers"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test/*`.split("\n")
  gem.name          = "bystander"
  gem.require_paths = ["lib"]
  gem.version       = Bystander::VERSION

  gem.add_development_dependency 'rake'
end

