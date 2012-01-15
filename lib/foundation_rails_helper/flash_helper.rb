require 'action_view/helpers'

module FoundationRailsHelper
  module FlashHelper
    # <div class="alert-box [success warning error]">
    #   This is a success alert (div.alert-box.success).
    #   <a href="" class="close">&times;</a>
    # </div>
    KEY_MATCHING = {
      :notice  => :success,
      :info    => :warning,
      :failure => :error,
      :alert   => :error,
    }
    def display_flash_messages
      flash.inject "" do |message, (key, value)| 
        message += content_tag :div, :class => "alert-box #{KEY_MATCHING[key] || key}" do
          (value + link_to("x", "#", :class => :close)).html_safe
        end
      end.html_safe
    end
  end
end
