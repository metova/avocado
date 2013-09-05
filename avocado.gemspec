$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "avocado/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "avocado"
  s.version     = Avocado::VERSION
  s.authors     = ["Logan Serman"]
  s.email       = ["loganserman@gmail.com"]
  s.homepage    = "https://github.com/metova/avocado"
  s.summary     = "Generates JSON API documentation automatically from Cucumber tests"
  s.description = "Avocado produces HTML documentation for JSON APIs based on Cucumber tests. The documentation is generated automatically everytime you run Cucumber."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "jquery-rails"
  s.add_development_dependency "sqlite3"
end
