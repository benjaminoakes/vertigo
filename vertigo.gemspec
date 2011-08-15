# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vertigo/version"

Gem::Specification.new do |s|
  s.name        = "vertigo"
  s.version     = Vertigo::VERSION
  s.authors     = ["Benjamin Oakes"]
  s.email       = ["boakes@hedgeye.com"]
  s.homepage    = ""
  s.summary     = %q{A simple Ruby wrapper around the VerticalResponse API ("VRAPI").}
  s.description = %q{Vertigo makes working with VerticalResponse's SOAP API much more Ruby-like.  It manages your session_id, as well as letting you write methods as launch_email_campaign rather than launchEmailCampaign, and use symbols as keys rather than strings.}

  s.rubyforge_project = "vertigo"
  
  s.add_dependency('soap4r', '~> 1.5.8')

  s.add_development_dependency('rake', '~> 0.8.7')
  s.add_development_dependency('rspec', '~> 2.6.0')
  s.add_development_dependency('yard', '< 1.0.0')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
