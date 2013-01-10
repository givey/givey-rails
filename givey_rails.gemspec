$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "givey_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "givey_rails"
  s.version     = GiveyRails::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GiveyRails."
  s.description = "TODO: Description of GiveyRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "givey_ruby"
  s.add_dependency "eu_central_bank"
  s.add_dependency "simple_form"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "log_buddy"
end
