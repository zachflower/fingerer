# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fingerer/version'

Gem::Specification.new do |spec|
  spec.name          = "fingerer"
  spec.version       = Fingerer::VERSION
  spec.authors       = ["Zachary Flower"]
  spec.email         = ["zach@zacharyflower.com"]
  spec.description   = %q{Fingerer is a finger server that returns the GitHub profile associated with the provided username. Quickly lookup GitHub user and organization information using a standard finger command.}
  spec.summary       = %q{Lookup GitHub profile information using a standard finger command.}
  spec.homepage      = "https://zacharyflower.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "octokit", "~> 4.0"
  spec.add_development_dependency "daemons", "~> 1.2"
  spec.add_development_dependency "rake"
end
