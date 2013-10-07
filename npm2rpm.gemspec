# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "npm2rpm/version"

Gem::Specification.new do |s|
  s.name        = "npm2rpm"
  s.version     = Npm2Rpm::VERSION

  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Klaus Kämpf"]
  s.email       = ["kkaempf@suse.de"]
  s.homepage    = "https://github.com/kkaempf/npm2rpm"
  s.summary     = %q{Generate RPM packages for Nodejs modules}
  s.description = %q{Automatically generates RPM packages for Nodejs modules}

  s.rubyforge_project = "npm2rpm"

  s.files         = `git ls-files`.split("\n")
  s.files.reject! { |fn| fn == '.gitignore' }
  s.extra_rdoc_files    = Dir['README.md', 'LICENSE']
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
