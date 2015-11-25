# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'terrascript/version'

Gem::Specification.new do |spec|
  spec.name        = 'terrascript'
  spec.version     = Terrascript.VERSION
  spec.date        = '2015-11-25'
  spec.summary     = 'Terraform DSL generator'
  spec.description = <<-EOS
  Allows you to generate terraform compatible DSL.
  Providers utmose flexibility to call it from your code and
  kills the limitations that HCL has
  EOS
  spec.authors     = ['Piyush Verma']
  spec.email       = 'piyush@datascale.io'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.homepage    = 'https://github.com/meson10/terrascript'
  spec.license     = 'MIT'

  spec.add_dependency 'netaddr'
  spec.add_dependency 'virtus'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
