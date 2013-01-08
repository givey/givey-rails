$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "givey-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "givey-rails"
  s.version     = GiveyRails::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GiveyRails."
  s.description = "TODO: Description of GiveyRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.10"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
