ActionView::Base.default_form_builder = FoundationRailsHelper::FormBuilder
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag
end
