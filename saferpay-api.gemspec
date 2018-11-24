$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'saferpay/api/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'saferpay-api'
  s.version     = Saferpay::Api::VERSION
  s.authors     = ['Patrick Pinto']
  s.email       = ['patrick.cb3@gmail.com']
  s.homepage    = 'https://saferpay.github.io/jsonapi/'
  s.summary     = 'Client for Saferpay API'
  s.description = 'Client for Saferpay API'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'faraday', '< 1'

  s.add_development_dependency 'rubocop', '< 1'
end
