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
  # s.add_dependency "trix-rails"
  s.add_dependency "simple_form"
  s.add_dependency "audited", "~> 4.7"
  # s.add_dependency "best_in_place"
  # s.add_dependency "cocoon"
  s.add_dependency "recaptcha"
  # s.add_dependency "meta-tags"
  s.add_dependency "activestorage-validator" # NOTE: This gem had a Rails 6 compatibility issue but is now reinstated on page and article models.
  s.add_dependency "jquery-atwho-rails" # This might not really be required...
  # s.add_dependency "fiat_notificiatons"

  s.add_development_dependency "sqlite3"
end
