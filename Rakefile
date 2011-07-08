require "rubygems"

require 'rake'
require "rake/gempackagetask"

spec = Gem::Specification.load "prawn-labels.gemspec"
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end