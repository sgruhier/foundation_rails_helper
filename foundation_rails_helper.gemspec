# -*- encoding: utf-8 -*-
require File.expand_path('../lib/foundation_rails_helper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Sebastien Gruhier']
  gem.email         = ['sebastien.gruhier@xilinus.com']
  gem.description   = 'Rails for zurb foundation CSS framework. Form builder, flash message, ...'
  gem.summary       = 'Rails helpers for zurb foundation CSS framework'
  gem.homepage      = 'http://github.com/sgruhier/foundation_rails_helper'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'foundation_rails_helper'
  gem.require_paths = ['lib']
  gem.version       = FoundationRailsHelper::VERSION
  gem.license       = 'MIT'

  # Allow different versions of the rails gems to be specified, for testing:
  rails_version = ENV['RAILS_VERSION'] || 'default'

  rails = case rails_version
          when 'default'
            '>= 4.1'
          else
            "~> #{rails_version}"
          end

  gem.add_dependency 'railties',      rails
  gem.add_dependency 'actionpack',    rails
  gem.add_dependency 'activemodel',   rails
  gem.add_dependency 'activesupport', rails
  gem.add_dependency 'tzinfo',        '~> 1.2', '>= 1.2.2'

  gem.add_development_dependency 'rspec-rails', '>= 3.1'
  gem.add_development_dependency 'mime-types',  '~> 2'
  gem.add_development_dependency 'capybara',    '~> 2.7'
  gem.add_development_dependency 'rubocop',     '~> 0.44.1'
end
