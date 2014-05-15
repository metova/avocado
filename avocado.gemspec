$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "avocado/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "avocado"
  s.version     = Avocado::VERSION
  s.authors     = ["Logan Serman"]
  s.email       = ["loganserman@gmail.com"]
  s.homepage    = "http://github.com/metova/avocado"
  s.summary     = "Automatic API documentation from RSpec tests"
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "multipart-post"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "combustion"
  s.add_development_dependency "webmock"

end
