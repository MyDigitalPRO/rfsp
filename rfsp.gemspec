# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rfsp/version'

Gem::Specification.new do |spec|
  spec.name          = 'rfsp'
  spec.version       = RFSP::VERSION
  spec.authors       = ['Ibrahim Ivanko']
  spec.email         = ['ibrahim-ivanko@mdtlpr.com']
  spec.summary       = %q{Russian Freelance Site Parser}
  spec.description   = %q{Get projects from www.fl.ru www.weblancer.net freelansim.ru}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest_client', '~> 1.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.0'
  spec.add_runtime_dependency 'feedjira', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec-core', '~> 3.0'
  spec.add_development_dependency 'rspec-mocks'
  spec.add_development_dependency 'rspec-expectations', '~> 3.0'
  spec.add_development_dependency 'rr', '~> 1.0'
end
