# frozen_string_literal: true
ActionView::Base.default_form_builder = FoundationRailsHelper::FormBuilder
ActionView::Base.field_error_proc = proc do |html_tag, _instance_tag|
  html_tag
end
