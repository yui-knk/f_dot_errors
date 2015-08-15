# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'f_dot_errors/version'

Gem::Specification.new do |spec|
  spec.name          = "f_dot_errors"
  spec.version       = FDotErrors::VERSION
  spec.authors       = ["yui-knk"]
  spec.email         = ["spiketeika@gmail.com"]

  spec.summary       = %q{Add `f.errors(:method)` to Rails view}
  spec.description   = %q{Add `f.errors(:method)` to Rails view}
  spec.homepage      = "https://github.com/yui-knk/f_dot_errors"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails"
end
