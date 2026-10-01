# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid/random/version"

Gem::Specification.new do |s|
  s.name        = "mongoid-random"
  s.version     = Mongoid::Random::VERSION
  s.authors     = ["Dave Krupinski"]
  s.email       = ["dave@davekrupinski.com"]
  s.homepage    = "https://github.com/davekrupinski/mongoid-random"
  s.summary     = "Randomization extensions for Mongoid documents"
  s.description = "Add a random key to all documents in a collection for random retrieval"

  s.rubyforge_project = "mongoid-random"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('mongoid', [ '>= 3.0.0', '< 10' ])

  s.add_development_dependency('rspec', [ '~> 3.13' ])
  s.add_development_dependency('rake')
  s.add_development_dependency('database_cleaner-mongoid')

end
