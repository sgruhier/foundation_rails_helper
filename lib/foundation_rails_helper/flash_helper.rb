require 'action_view/helpers'

module FoundationRailsHelper
  module FlashHelper
    # <div class="alert-box [success alert secondary]">
    #   This is an alert box.
    #   <a href="" class="close">&times;</a>
    # </div>
    DEFAULT_KEY_MATCHING = {
      :alert     => 'alert',
      :notice    => 'success',
      :info      => 'info',
      :secondary => 'secondary',
      :success   => 'success',
      :error     => 'alert',
      :warning   => 'warning'
    }

    def display_flash_messages(opts={})
      key_matching = opts.delete(:key_matching) || {}
      key_matching = DEFAULT_KEY_MATCHING.merge(key_matching)

      dismiss_toggle = opts[:dismiss_toggle]
      alert_style = opts[:style]

      capture do
        flash.each do |key, value|
          next if FoundationRailsHelper.configuration.ignored_flash_keys.include? key.to_sym
          alert_class = key_matching[key.to_sym]
          concat alert_box(value, alert_class, alert_style, dismiss_toggle)
        end
      end
    end

  private

    def alert_box(value, alert_class, alert_style=nil, dismiss_toggle)
      content_tag :div, :data => { :alert => true }, :class => "alert-box #{alert_class} #{alert_style}" do
        concat value
        concat close_link(dismiss_toggle) unless dismiss_toggle.eql?(false)
      end
    end

    def close_link(dismiss_toggle=nil)
      dismiss_toggle ||= "&times;".html_safe
      link_to(dismiss_toggle, "#", :class => :close)
    end

  end
end
