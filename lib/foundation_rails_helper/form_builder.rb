require 'action_view/helpers'

module FoundationRailsHelper
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    %w(file_field email_field text_field text_area telephone_field phone_field
       url_field number_field date_field datetime_field datetime_local_field
       month_field week_field time_field range_field search_field color_field)
      .each do |method_name|
      define_method(method_name) do |*args|
        attribute = args[0]
        options   = args[1] || {}
        field(attribute, options) do |opts|
          super(attribute, opts)
        end
      end
    end

    def label(attribute, text = nil, options = {})
      if has_error?(attribute)
        options[:class] ||= ''
        options[:class] += ' error'
      end

      super(attribute, (text || '').html_safe, options)
    end

    def check_box(attribute, options = {}, checked_value = '1', unchecked_value = '0')
      custom_label(attribute, options[:label], options[:label_options]) do
        options.delete(:label)
        options.delete(:label_options)
        super(attribute, options, checked_value, unchecked_value)
      end + error_and_hint(attribute, options)
    end

    def radio_button(attribute, tag_value, options = {})
      options[:label_options] ||= {}
      label_options = options.delete(:label_options).merge!(value: tag_value)
      label_text = options.delete(:label)
      unless label_text == false
        l = label(attribute, label_text, label_options)
      end
      r = @template.radio_button(@object_name, attribute, tag_value,
                                 objectify_options(options))

      "#{r}#{l}".html_safe
    end

    def password_field(attribute, options = {})
      field attribute, options do |opts|
        super(attribute, opts.merge(:autocomplete => :off))
      end
    end

    def datetime_select(attribute, options = {}, html_options = {})
      field attribute, options, html_options do |html_opts|
        super(attribute, options, html_opts.merge(:autocomplete => :off))
      end
    end

    def date_select(attribute, options = {}, html_options = {})
      field attribute, options, html_options do |html_opts|
        super(attribute, options, html_opts.merge(:autocomplete => :off))
      end
    end

    def time_zone_select(attribute, priorities = nil, options = {}, html_options = {})
      field attribute, options, html_options do |html_opts|
        super(attribute, priorities, options,
              html_opts.merge(:autocomplete => :off))
      end
    end

    def select(attribute, choices, options = {}, html_options = {})
      field attribute, options, html_options do |html_opts|
        html_options[:autocomplete] ||= :off
        super(attribute, choices, options, html_opts)
      end
    end

    def collection_select(attribute, collection, value_method, text_method, options = {}, html_options = {})
      field attribute, options, html_options do |html_opts|
        html_options[:autocomplete] ||= :off
        super(attribute, collection, value_method, text_method, options,
              html_opts)
      end
    end

    def grouped_collection_select(attribute, collection, group_method, group_label_method, option_key_method, option_value_method, options = {}, html_options = {})
      field attribute, options, html_options do |html_opts|
        html_options[:autocomplete] ||= :off
        super(attribute, collection, group_method, group_label_method,
              option_key_method, option_value_method, options, html_opts)
      end
    end

    def autocomplete(attribute, url, options = {})
      field attribute, options do |opts|
        opts.merge!(:update_elements => opts[:update_elements],
                    :min_length => 0, :value => object.send(attribute))
        autocomplete_field(attribute, url, opts)
      end
    end

    def submit(value = nil, options = {})
      options[:class] ||= FoundationRailsHelper.configuration.button_class
      super(value, options)
    end

  private

    def has_error?(attribute)
      object.respond_to?(:errors) && !object.errors[attribute].blank?
    end

    def error_for(attribute, options = {})
      class_name = 'error'
      class_name += " #{options[:class]}" if options[:class]

      return unless has_error?(attribute)

      error_messages = object.errors[attribute].join(', ')
      error_messages = error_messages.html_safe if options[:html_safe_errors]
      content_tag(:small, error_messages, :class => class_name)
    end

    def custom_label(attribute, text, options, &block)
      return block_given? ? block.call.html_safe : ''.html_safe if text == false
      if text.nil? || text == true
        text =
          if object.class.respond_to?(:human_attribute_name)
            object.class.human_attribute_name(attribute)
          else
            attribute.to_s.humanize
          end
      end
      text = block.call.html_safe + " #{text}" if block_given?
      options ||= {}
      label(attribute, text, options)
    end

    def column_classes(options)
      classes = "columns"
      classes << " small-#{options[:small]}" if [*1..11].include?(options[:small].try(:to_i))
      classes << " medium-#{options[:medium]}" if [*1..11].include?(options[:medium].try(:to_i))
      classes << " large-#{options[:large]}" if [*1..11].include?(options[:large].try(:to_i))
      classes
    end

    def tag_from_options(name, options)
      return ''.html_safe unless options && options[:value].present?

      content_tag(:div,
        content_tag(:span, options[:value], :class => name),
        :class => "#{ column_classes( options ) }")
    end

    def decrement_input_size(input, column, options)
      return unless options.key?(column)

      input.send("#{column}=",
                 (input.send(column) - options.fetch(column).to_i))
      input.send('changed?=', true)
    end

    def calculate_input_size(prefix_options, postfix_options)
      input_size =
        OpenStruct.new(changed?: false, small: 12, medium: 12, large: 12)
      if prefix_options.present?
        %w(small medium large).each do |size|
          decrement_input_size(input_size, size.to_sym, prefix_options)
        end
      end
      if postfix_options.present?
        %w(small medium large).each do |size|
          decrement_input_size(input_size, size.to_sym, postfix_options)
        end
      end

      input_size
    end

    def wrap_prefix_and_postfix(block, prefix_options, postfix_options)
      prefix = tag_from_options("prefix", prefix_options)
      postfix = tag_from_options("postfix", postfix_options)

      input_size = calculate_input_size(prefix_options, postfix_options)

      row_classes = "row collapse"
      if prefix_options.try(:[], :input_style).present?
        row_classes << " prefix-#{prefix_options[:input_style]}"
      end
      if postfix_options.try(:[], :input_style).present?
        row_classes << " postfix-#{postfix_options[:input_style]}"
      end

      input_classes = column_classes(input_size.marshal_dump)
      input = content_tag(:div, block, class: input_classes)

      html = if input_size.changed?
        content_tag(:div, prefix << input << postfix, class: row_classes)
      else
        block
      end
      html.html_safe
    end

    def error_and_hint(attribute, options = {})
      html = ''
      if options[:hint]
        html += content_tag(:span, options[:hint], :class => :hint)
      end
      html += error_for(attribute, options) || ''
      html.html_safe
    end

    def field(attribute, options, html_options = nil, &block)
      if @options[:auto_labels] || options[:label]
        html = custom_label(attribute, options[:label], options[:label_options])
      else
        html = ''.html_safe
      end
      class_options = html_options || options

      if has_error?(attribute)
        class_options[:class] = class_options[:class].to_s
        class_options[:class] += ' error'
      end

      options.delete(:label)
      options.delete(:label_options)
      hint = options.delete(:hint)
      prefix = options.delete(:prefix)
      postfix = options.delete(:postfix)

      html += wrap_prefix_and_postfix(yield(class_options), prefix, postfix)
      html + error_and_hint(attribute, options.merge(hint: hint))
    end
  end
end
