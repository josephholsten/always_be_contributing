# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'always_be_contributing/version'

Gem::Specification.new do |spec|
  spec.name              = "always_be_contributing"
  spec.version           = AlwaysBeContributing::VERSION
  spec.author            = "Joseph Anthony Pasquale Holsten"
  spec.email             = "joseph@josephholsten.com"
  spec.homepage          = "https://github.com/josephholsten/always_be_contributing"
  spec.description = <<-EOF
    Always Be Contributing counts who has
    contributing most to your organization on Github.
  EOF
  spec.extra_rdoc_files  = %w[ LICENSE README.md ]
  spec.rdoc_options      << "--title" << "Always Be Contributing Documentation" <<
                            "--main"  << "README.md"
  spec.license           = 'ISC'
  spec.summary           = spec.description.split(/\.\s+/).first
  spec.files             = `git ls-files`.split($/)
  spec.executables       = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files        = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rdoc', '>= 4.0.0'
  spec.add_development_dependency 'minitest', '>= 5'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'ruby-appraiser'
  spec.add_development_dependency 'ruby-appraiser-rubocop'
  spec.add_development_dependency 'ruby-appraiser-reek'

  spec.add_runtime_dependency 'octokit'
  spec.add_runtime_dependency 'peach'
  spec.add_runtime_dependency 'netrc'
  spec.add_runtime_dependency 'ruby-progressbar'
end
