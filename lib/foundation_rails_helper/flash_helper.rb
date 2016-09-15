require 'action_view/helpers'

module FoundationRailsHelper
  module FlashHelper
    # <div class="callout [success alert secondary]" data-closable>
    #   This is an alert box.
    #   <button name="button" type="submit" class="close-button" data-close="">
    #     <span>&times;</span>
    #   </button>
    # </div>
    DEFAULT_KEY_MATCHING = {
      :alert     => :alert,
      :notice    => :success,
      :info      => :primary,
      :secondary => :secondary,
      :success   => :success,
      :error     => :alert,
      :warning   => :warning,
      :primary   => :primary
    }.freeze
    def display_flash_messages(**options)
      closable = true
      closable = options.delete(:closable) if options.has_key?(:closable)
      key_matching = DEFAULT_KEY_MATCHING.merge(options)
      key_matching.default = :primary

      capture do
        flash.each do |key, value|
          next if FoundationRailsHelper.configuration.ignored_flash_keys.include? key.to_sym
          alert_class = key_matching[key.to_sym]
          concat alert_box(value, alert_class, closable)
        end
      end
    end

  private

    def alert_box(value, alert_class, closable)
      options = { class: "flash callout #{alert_class}" }
      options[:data] = { closable: '' } if closable
      content_tag(:div, options) do
        concat value
        concat close_link if closable
      end
    end

    def close_link
      button_tag(
        class: 'close-button',
        type: 'button',
        data: { close: '' },
        aria: { label: 'Dismiss alert' }
      ) do
        content_tag(:span, '&times;'.html_safe, aria: { hidden: true })
      end
    end
  end
end
