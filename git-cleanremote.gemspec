# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git-cleanremote/version'

Gem::Specification.new do |gem|
  gem.name          = "git-cleanremote"
  gem.version       = Git::CleanRemoteVersion::STRING
  gem.authors       = ["Jason Waldrip"]
  gem.email         = ["jason@waldrip.net"]
  gem.description   = %{A command line tool to clean up remote repositories.}
  gem.summary       = %{A command line tool to clean up remote repositories.}
  gem.homepage      = "https://github.com/jwaldrip/git-cleanremote"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "thor", "~> 0.17.0"
  gem.add_dependency "open4"

  # gem.add_development_dependency "rspec", "~> 2.12.0" # Todo: add some specs/tests.
  gem.add_development_dependency "pry"

end
