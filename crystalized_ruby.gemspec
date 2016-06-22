# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crystalized_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "crystalized_ruby"
  spec.version       = CrystalizedRuby::VERSION
  spec.authors       = ["Paul Hoffer", "Fabio Akita"]
  spec.email         = ["fabioakita@gmail.com"]

  spec.summary       = %q{Creating bindings and wrappers to create native extensions for Ruby in Crystal}
  spec.description   = %q{Series of wrappers and experiments to show how to implement native extensions for MRI Ruby in Crystal}
  spec.homepage      = "https://github.com/phoffer/crystalized_ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "benchmark-ips", "~> 2.6", ">= 2.6.1"
  spec.add_development_dependency "activesupport", "5.0.0.rc1"
  spec.add_development_dependency "fast_blank", "1.0.0"
  spec.add_development_dependency "descriptive_statistics", "~> 2.5", ">= 2.5.1"

  spec.extensions    = %w[ext/extconf.rb]
end
