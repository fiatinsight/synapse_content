$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "synapse_content/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "synapse_content"
  s.version     = SynapseContent::VERSION
  s.authors       = ["Andrew Haines"]
  s.email         = ["andrew@fiatinsight.com"]
  s.summary       = "Fiat Insight publication tools"
  s.description   = "This is a Rails engine for quickly setting up a flexible publication module."
  s.homepage      = "https://github.com/fiatinsight/synapse_content"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.2.1"
  s.add_dependency "simple_form"
  # s.add_dependency "audited", "~> 4.7" # Add this in the future?
  s.add_dependency "recaptcha"
  # s.add_dependency "activestorage-validator" # Add this in the future?
  # s.add_dependency "jquery-atwho-rails" # This might not really be required...

  s.add_development_dependency "sqlite3"
end
