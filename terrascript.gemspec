Gem::Specification.new do |s|
  s.name        = 'terrascript'
  s.version     = '0.0.1'
  s.date        = '2015-11-25'
  s.summary     = 'Terraform DSL generator'
  s.description = <<-EOS
  Allows you to generate terraform compatible DSL.
  Providers utmose flexibility to call it from your code and
  kills the limitations that HCL has
  EOS
  s.authors     = ['Piyush Verma']
  s.email       = 'piyush@datascale.io'
  s.files       = ["lib/hola.rb"]
  s.homepage    = 'https://github.com/meson10/terrascript'
  s.license     = 'MIT'
end
