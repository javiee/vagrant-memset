# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$:.unshift File.expand_path("../lib", __FILE__)
require 'vagrant-memset/version'

Gem::Specification.new do |gem|
  gem.name          = "vagrant-memset"
  gem.version       = VagrantPlugins::Memset::VERSION
  gem.authors       = ["Javier Caro Ruiz"]
  gem.email         = ["javienet@gmail.com"]
  gem.summary       = %q{Memset CLoud provider}
  gem.description   = %q{Allows to communicate Vagrant with Memset API}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.6"
  gem.add_development_dependency "rake"
end
