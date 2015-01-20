require 'action_view/helpers'

module FoundationRailsHelper
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    %w(file_field email_field text_field text_area telephone_field phone_field
       url_field number_field date_field datetime_field datetime_local_field
       month_field week_field time_field range_field search_field color_field ).each do |method_name|
      define_method(method_name) do |*args|
        attribute = args[0]
        options   = args[1] || {}
        field(attribute, options) do |options|
          super(attribute, options)
        end
      end
    end

    def label(attribute, text = nil, options = {})
      options[:class] ||= ""
      options[:class] += " error" if has_error?(attribute)
      super(attribute, (text || "").html_safe, options)
    end


    def check_box(attribute, options = {}, checked_value = "1", unchecked_value = "0")
      custom_label(attribute, options[:label], options[:label_options]) do
        options.delete(:label)
        options.delete(:label_options)
        super(attribute, options, checked_value, unchecked_value)
      end + error_and_hint(attribute, options)
    end

    def radio_button(attribute, tag_value, options = {})
      r = @template.radio_button(@object_name, attribute, tag_value, objectify_options(options))
      l = label(attribute, options.delete(:text), options.merge!(value: tag_value))

      "#{r}#{l}".html_safe
    end

    def password_field(attribute, options = {})
      field attribute, options do |options|
        super(attribute, options.merge(:autocomplete => :off))
      end
    end

    def datetime_select(attribute, options = {}, html_options = {})
      field attribute, options, html_options do |html_options|
        super(attribute, options, html_options.merge(:autocomplete => :off))
      end
    end

    def date_select(attribute, options = {}, html_options = {})
      field attribute, options, html_options do |html_options|
        super(attribute, options, html_options.merge(:autocomplete => :off))
      end
    end

    def time_zone_select(attribute, priorities = nil, options = {}, html_options = {})
      field attribute, options, html_options do |html_options|
        super(attribute, priorities, options, html_options.merge(:autocomplete => :off))
      end
    end

    def select(attribute, choices, options = {}, html_options = {})
      field attribute, options, html_options do |html_options|
        html_options[:autocomplete] ||= :off
        super(attribute, choices, options, html_options)
      end
    end

    def collection_select(attribute, collection, value_method, text_method, options = {}, html_options = {})
      field attribute, options, html_options do |html_options|
        html_options[:autocomplete] ||= :off
        super(attribute, collection, value_method, text_method, options, html_options)
      end
    end

    def grouped_collection_select(attribute, collection, group_method, group_label_method, option_key_method, option_value_method, options = {}, html_options = {})
      field attribute, options, html_options do |html_options|
        html_options[:autocomplete] ||= :off
        super(attribute, collection, group_method, group_label_method, option_key_method, option_value_method, options, html_options)
      end
    end

    def autocomplete(attribute, url, options = {})
      field attribute, options do |options|
        autocomplete_field(attribute, url, options.merge(:update_elements => options[:update_elements],
                                                         :min_length => 0,
                                                         :value => object.send(attribute)))
      end
    end

    def submit(value=nil, options={})
      options[:class] ||= FoundationRailsHelper.configuration.button_class
      super(value, options)
    end

  private
    def has_error?(attribute)
      object.respond_to?(:errors) && !object.errors[attribute].blank?
    end

    def error_for(attribute, options = {})
      class_name = "error"
      class_name += " #{options[:class]}" if options[:class]
      if has_error?(attribute)
        error_messages = object.errors[attribute].join(', ')
        error_messages = error_messages.html_safe if options[:html_safe_errors]
        content_tag(:small, error_messages, :class => class_name)
      end
    end

    def custom_label(attribute, text, options, &block)
      return block_given? ? block.call.html_safe : "".html_safe if text == false
      if text.nil? || text == true
        text = if object.class.respond_to?(:human_attribute_name)
          object.class.human_attribute_name(attribute)
        else
          attribute.to_s.humanize
        end
      end
      text = block.call.html_safe + " #{text}" if block_given?
      options ||= {}
      options[:class] ||= ""
      options[:class] += " error" if has_error?(attribute)
      label(attribute, text, options)
    end

    def error_and_hint(attribute, options = {})
      html = ""
      html += content_tag(:span, options[:hint], :class => :hint) if options[:hint]
      html += error_for(attribute, options) || ""
      html.html_safe
    end

    def field(attribute, options, html_options=nil, &block)
      html = ''.html_safe
      html = custom_label(attribute, options[:label], options[:label_options]) if @options[:auto_labels] || options[:label]
      class_options = html_options || options
      class_options[:class] = class_options[:class].to_s
      class_options[:class] += " error" if has_error?(attribute)
      options.delete(:label)
      options.delete(:label_options)
      html += yield(class_options)
      html += error_and_hint(attribute, options)
    end
  end
end
