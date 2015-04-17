# coding: utf-8

Gem::Specification.new do |s|
  s.name          = 'options'
  s.version       = '1.0.1'
  s.author        = 'Pierre BAZONNARD'
  s.email         = ['pierre@bazonnard.fr']
  s.homepage      = 'http://tobedefined/'
  s.summary       = 'Simple options parser'
  s.description   = 'Inspired by slop'
  s.license       = 'MIT'

  s.files         = ['lib/options.rb']
  s.executables   = []
  s.test_files    = []
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.1.0'
#  s.add_dependency 

  s.add_development_dependency 'rake',     '~> 0'
  s.add_development_dependency 'minitest', '= 5.4.2'
end
