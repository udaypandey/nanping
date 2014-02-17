# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "nanping/version"

Gem::Specification.new do |s|
  s.name        = "iosbuild"
  s.authors     = ["Uday Pandey"]
  s.email       = "uday.pandey@gmail.com"
  s.homepage    = "http://www.thirstysea.com"
  s.version     = Nanping::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "iosbuild"
  s.description = "CLI for tweaking plist files for Building & Distributing iOS Apps (.ipa Files)"

  s.add_dependency "commander", "~> 4.1"
  s.add_dependency "json", "~> 1.8"

  s.add_development_dependency "rake"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end