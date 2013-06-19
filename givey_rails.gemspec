$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "givey_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "givey_rails"
  s.version     = GiveyRails::VERSION
  s.authors     = ["Nick Reavill", "Philip Poots"]
  s.email       = ["nick@givey.com", "philip@givey.com"]
  s.homepage    = "http://www.givey.com"
  s.summary     = "Summary of GiveyRails."
  s.description = "Description of GiveyRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "givey_ruby", "0.0.6"
  s.add_dependency "strong_parameters"
  s.add_dependency "eu_central_bank"
  s.add_dependency "RedCloth"
  s.add_dependency "hashie"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "log_buddy"
end
