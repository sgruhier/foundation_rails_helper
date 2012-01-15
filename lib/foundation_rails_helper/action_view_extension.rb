module ActionView
  module Helpers
    module FormHelper
      def form_for_with_foundation(record, options = {}, &block)
        options[:builder] ||= FoundationRailsHelper::FormBuilder
        options[:html] ||= {}
        options[:html][:class] ||= 'nice'
        form_for_without_foundation(record, options, &block) 
      end
      
      def fields_for_with_foundation(record_name, record_object = nil, options = {}, &block)
        options[:builder] ||= FoundationRailsHelper::FormBuilder
        options[:html] ||= {}
        options[:html][:class] ||= 'nice'
        fields_for_without_foundation(record_name, record_object, options, &block)
      end
      
      alias_method_chain :form_for, :foundation
      alias_method_chain :fields_for, :foundation
    end
  end
end
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag
end