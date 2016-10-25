require File.expand_path('../lib/foundation_rails_helper/version', __FILE__)

def rails_gem_version
  # Allow different versions of the rails gems to be specified, for testing:
  @rails_gem_version ||=
    case ENV['RAILS_VERSION']
    when nil
      '>= 4.1'
    else
      "~> #{ENV['RAILS_VERSION']}"
    end
end

Gem::Specification.new do |gem|
  gem.authors = ['Sebastien Gruhier']
  gem.email = ['sebastien.gruhier@xilinus.com']
  gem.description =
    'Rails for zurb foundation CSS framework. Form builder, flash message, ...'
  gem.summary = 'Rails helpers for zurb foundation CSS framework'
  gem.homepage = 'http://github.com/sgruhier/foundation_rails_helper'

  gem.executables =
    `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name = 'foundation_rails_helper'
  gem.require_paths = %w(lib)
  gem.version = FoundationRailsHelper::VERSION
  gem.license = 'MIT'

  gem.add_dependency 'railties', rails_gem_version
  gem.add_dependency 'actionpack', rails_gem_version
  gem.add_dependency 'activemodel', rails_gem_version
  gem.add_dependency 'activesupport', rails_gem_version
  gem.add_dependency 'tzinfo', '~> 1.2', '>= 1.2.2'

  gem.add_development_dependency 'rspec-rails', '>= 3.1'
  gem.add_development_dependency 'mime-types', '~> 2'
  gem.add_development_dependency 'capybara', '~> 2.7'
  gem.add_development_dependency 'rubocop', '~> 0.44.1'
end
