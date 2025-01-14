# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name                  = 'ruby-hotfile'
  spec.version               = '0.1.1'
  spec.summary               = 'Ruby HOTfile parser'
  spec.description           = 'Parser for IATA HOT files (accounting/sales data) as described in IATA BSP DISH.'
  spec.authors               = ['Ferry Landzaat']
  spec.files                 = Dir['lib/**/*.rb']
  spec.homepage              = 'https://github.com/fjl82/ruby-hotfile'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'
end
