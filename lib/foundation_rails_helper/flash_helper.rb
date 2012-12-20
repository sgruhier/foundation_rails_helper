require 'action_view/helpers'

module FoundationRailsHelper
  module FlashHelper
    # <div class="alert-box [success alert secondary]">
    #   This is an alert box.
    #   <a href="" class="close">&times;</a>
    # </div>
    KEY_MATCHING = {
      :alert   => :standard,
      :notice  => :success,
      :failure => :alert,
      :info    => :secondary,
    }
    def display_flash_messages
      flash.inject "" do |message, (key, value)| 
        message += content_tag :div, :class => "alert-box #{KEY_MATCHING[key] || key unless KEY_MATCHING[key] == :standard}" do
          (value + link_to("&times;".html_safe, "#", :class => :close)).html_safe
        end
      end.html_safe
    end
  end
end
