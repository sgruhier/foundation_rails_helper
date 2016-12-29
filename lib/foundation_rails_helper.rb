# frozen_string_literal: true
require 'foundation_rails_helper/version'
require 'foundation_rails_helper/configuration'
require 'foundation_rails_helper/form_builder'
require 'foundation_rails_helper/size_class_calculator'
require 'foundation_rails_helper/flash_helper'
require 'foundation_rails_helper/action_view_extension'
ActiveSupport.on_load(:action_view) do
  include FoundationRailsHelper::FlashHelper
end
