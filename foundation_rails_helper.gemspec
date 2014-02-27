# -*- encoding: utf-8 -*-
require File.expand_path('../lib/foundation_rails_helper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sebastien Gruhier"]
  gem.email         = ["sebastien.gruhier@xilinus.com"]
  gem.description   = %q{Rails for zurb foundation CSS framework. Form builder, flash message, ...}
  gem.summary       = %q{Rails helpers for zurb foundation CSS framework}
  gem.homepage      = "http://github.com/sgruhier/foundation_rails_helper"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "foundation_rails_helper"
  gem.require_paths = ["lib"]
  gem.version       = FoundationRailsHelper::VERSION

  gem.add_dependency 'railties', '>= 3.0'
  gem.add_dependency "actionpack", '>= 3.0'
  gem.add_dependency "activemodel", '>= 3.0'
  gem.add_dependency "tzinfo", "~> 0.3.37"
  gem.add_development_dependency "rspec-rails", '2.8.1'
  gem.add_development_dependency "capybara"
end
