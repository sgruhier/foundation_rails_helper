require 'action_view/helpers'

module FoundationRailsHelper
  module FlashHelper
    # <div class="alert-box [success alert secondary]">
    #   This is an alert box.
    #   <a href="" class="close">&times;</a>
    # </div>
    DEFAULT_KEY_MATCHING = {
      alert: :alert,
      notice: :success,
      info: :info,
      secondary: :secondary,
      success: :success,
      error: :alert,
      warning: :warning
    }.freeze
    def display_flash_messages(key_matching = {})
      key_matching = DEFAULT_KEY_MATCHING.merge(key_matching)
      key_matching.default = :standard

      capture do
        flash.each do |key, value|
          next if FoundationRailsHelper.configuration.ignored_flash_keys.include? key.to_sym
          alert_class = key_matching[key.to_sym]
          concat alert_box(value, alert_class)
        end
      end
    end

    private

    def alert_box(value, alert_class)
      content_tag :div, data: { alert: '' }, class: "alert-box #{alert_class}" do
        concat value
        concat close_link
      end
    end

    def close_link
      link_to('&times;'.html_safe, '#', class: :close)
    end
  end
end
