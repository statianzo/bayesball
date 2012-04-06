# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bayesball/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Staten"]
  gem.email         = ["jstaten07@gmail.com"]
  gem.description   = %q{A bayes classifier}
  gem.summary       = %q{A bayes classifier}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "bayesball"
  gem.require_paths = ["lib"]
  gem.version       = Bayesball::VERSION
end
