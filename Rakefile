require "rubygems"
require "rubygems/package_task"

spec = Gem::Specification.load "prawn-labels.gemspec"

Gem::PackageTask.new(spec) do |pkg|

end

desc "Run a console with Prawn/Labels loaded"
task :console do
  require 'irb'
  require 'irb/completion'
  require_relative 'lib/prawn/labels'
  Prawn.debug = true

  ARGV.clear
  IRB.start
end
