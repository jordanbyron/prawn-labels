# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "prawn/labels/version"

Gem::Specification.new do |s|
  s.name        = "prawn-labels"
  s.version     = Prawn::Labels::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jordan Byron"]
  s.email       = ["jordan@ducksoupsoftware.com"]
  s.homepage    = ""
  s.summary     = %q{A Simple helper to generate labels for Prawn PDFs}
  s.description = %q{Makes it easy to generate labels using prawn}

  s.rubyforge_project = "prawn-labels"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('prawn')
end
