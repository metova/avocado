$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'avocado/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'avocado-docs'
  s.version     = Avocado::VERSION
  s.authors     = ['Logan Serman']
  s.email       = ['loganserman@gmail.com']
  s.homepage    = 'http://github.com/metova/avocado'
  s.summary     = 'Automatic API documentation from RSpec tests'
  s.description = 'Avocado listens for JSON responses in the test environment and generates a YAML file describing them, which it sends to a configurable URL.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '> 4'
  s.add_dependency 'multipart-post', '~> 2'

  s.add_development_dependency 'sqlite3', '~> 1.3'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'combustion', '~> 0.5'
  s.add_development_dependency 'webmock', '~> 1.15'
  s.add_development_dependency 'timecop'
end
