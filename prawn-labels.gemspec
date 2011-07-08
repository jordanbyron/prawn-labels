PRAWN_LABELS_VERSION = "0.11.1"

Gem::Specification.new do |spec|
  spec.name = "prawn-labels"
  spec.version = PRAWN_LABELS_VERSION
  spec.platform = Gem::Platform::RUBY
  spec.summary = "Make labels using Prawn"
  spec.files =  Dir.glob("{examples,lib}/**/**/*") +
                      ["Rakefile", "prawn-labels.gemspec"]
  spec.require_path = "lib"
  spec.required_ruby_version = '>= 1.8.7'
  spec.required_rubygems_version = ">= 1.3.6"

  spec.extra_rdoc_files = %w{README.md LICENSE COPYING}
  spec.rdoc_options << '--title' << 'Prawn/Labels Documentation' <<
                       '--main'  << 'README.md' << '-q'
  spec.authors = ["Jordan Byron"]
  spec.email = ["jordan.byron@gmail.com"]
  spec.rubyforge_project = "prawn-labels"
  spec.add_dependency('prawn', '~>0.11.1')
  spec.homepage = "http://github.com/jordanbyron/prawn-labels"
  spec.description = <<END_DESC
  Prawn/Labels takes the guess work out of generating labels using Prawn
END_DESC
end