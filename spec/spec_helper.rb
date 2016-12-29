# frozen_string_literal: true
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
require "foundation_rails_helper"
require "capybara"

# turning off deprecations
ActiveSupport::Deprecation.silenced = true
I18n.enforce_available_locales = false
