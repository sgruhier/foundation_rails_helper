require 'action_view/helpers'

module FoundationRailsHelper
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Context
    %w(file_field email_field text_field text_area telephone_field phone_field url_field number_field).each do |method_name|
      define_method(method_name) do |*args|
        attribute = args[0]
        options   = args[1] || {}
        field(attribute, options) do |options|
          super(attribute, options)
        end
      end
    end

    def check_box(attribute, options = {}, checked_value = "1", unchecked_value = "0")
      custom_label(attribute, options[:label], options[:label_options]) do
        options.delete(:label)
        options.delete(:label_options)
        super(attribute, options, checked_value, unchecked_value)
      end + error_and_hint(attribute, options)
    end

    def radio_button(attribute, tag_value, options = {})
      options[:for] ||= "#{@object_name}_#{attribute}_#{tag_value}"
      c = super(attribute, tag_value, options)
      l = label(attribute, options.delete(:text), options)
      l.gsub(/(for=\"\w*\"\>)/, "\\1#{c} ").html_safe
    end

    def password_field(attribute, options = {})
      field attribute, options do |options|
        super(attribute, options.merge(:autocomplete => :off))
      end
    end

    def datetime_select(attribute, options = {}, html_options = {})
      field attribute, html_options do |html_options|
        super(attribute, options, html_options.merge(:autocomplete => :off))
      end
    end

    def date_select(attribute, options = {}, html_options = {})
      field attribute, html_options do |html_options|
        super(attribute, options, html_options.merge(:autocomplete => :off))
      end
    end

    def time_zone_select(attribute, options = {})
      field attribute, options do |options|
        super(attribute, {}, options.merge(:autocomplete => :off))
      end
    end

    def select(attribute, choices, options = {}, html_options = {})
      field attribute, options do |options|
        html_options[:autocomplete] ||= :off
        super(attribute, choices, options, html_options)
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
      options[:class] ||= "small radius success button"
      if @options[:inline]
        content_tag :div, class: 'row' do
          content_tag :div, class: 'eight columns offset-by-four' do
            super(value, options)
          end
        end
      else
        super(value, options)
      end
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
      if text == false
        text = ""
      elsif text.nil?
        text = if object.class.respond_to?(:human_attribute_name)
          object.class.human_attribute_name(attribute)
        else
          attribute.to_s.humanize
        end
      end
      text = block.call.html_safe + text if block_given?
      options ||= {}
      options[:class] ||= ""
      options[:class] += " right inline" if @options[:inline]
      options[:class] += " error" if has_error?(attribute)
      label(attribute, text, options)
    end

    def error_and_hint(attribute, options = {})
      html = ""
      html += content_tag(:span, options[:hint], :class => :hint) if options[:hint]
      html += error_for(attribute, options) || ""
      html.html_safe
    end

    def field(attribute, options, &block)
      label = custom_label(attribute, options[:label], options[:label_options]) if false != options[:label]
      options[:class] ||= "medium"
      options[:class] = "#{options[:class]} input-text"
      options[:class] += " error" if has_error?(attribute)
      options.delete(:label)
      options.delete(:label_options)
      field = yield(options)
      field << error_and_hint(attribute, options)

      html = ''.html_safe
      if @options[:inline]
        html << inline_field(label, field)
      else
        html << label << field
      end
    end

    def inline_field(label, field)
      content_label = content_tag :div, class: 'four mobile-one columns' do
                        label
                      end
      content_field = content_tag :div, class: 'eight mobile-three columns' do
                        field
                      end
      content_tag :div, class: 'row' do
        content_label + content_field
      end
    end
  end
end
