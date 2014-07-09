# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragonfly_phantomjs/version'

Gem::Specification.new do |spec|
  spec.name          = "dragonfly_phantomjs"
  spec.version       = DragonflyPhantomjs::VERSION
  spec.authors       = ["Tomas Celizna"]
  spec.email         = ["tomas.celizna@gmail.com"]
  spec.summary       = %q{An encoder converting .html or .svg documents to .gif, .jpeg, .pdf or .png using PhantomJs}
  spec.description   = %q{An encoder converting .html or .svg documents to .gif, .jpeg, .pdf or .png using PhantomJs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "dragonfly", "~> 1.0.5"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
