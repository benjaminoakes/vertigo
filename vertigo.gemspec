# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vertigo/version"

Gem::Specification.new do |s|
  s.name        = "vertigo"
  s.version     = Vertigo::VERSION
  s.authors     = ["Benjamin Oakes"]
  s.email       = ["boakes@hedgeye.com"]
  s.homepage    = ""
  s.summary     = %q{Is the VerticalResponse API making you dizzy?}
  s.description = s.summary

  s.rubyforge_project = "vertigo"
  
  s.add_dependency('soap4r', '~> 1.5.8')

  s.add_development_dependency('fakeweb', '~> 1.3.0')
  s.add_development_dependency('rake', '~> 10.0.2')
  s.add_development_dependency('rspec', '~> 2.12.0')
  s.add_development_dependency('yard', '< 1.0.0')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
