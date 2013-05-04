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
    contributing most to your orginization on Github.
  EOF
  spec.extra_rdoc_files  = %w[ LICENSE README.rdoc ]
  spec.rdoc_options      << "--charset=UTF-8" <<
                            "--title" << "Always Be Contributing Documentation" <<
                            "--main"  << "README.rdoc"
  spec.license           = 'ISC'
  spec.summary           = spec.description.split(/\.\s+/).first
  spec.files             = `git ls-files`.split($/)
  spec.executables       = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files        = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rdoc'
end
