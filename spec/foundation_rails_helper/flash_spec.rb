require "spec_helper"

describe "FoundationRailsHelper::FlashHelper" do
  include ActionView::Context if defined?(ActionView::Context)
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include FoundationRailsHelper::FlashHelper

  %w(error warning success).each do |message_type|
    it "should display a flash for #{message_type} message" do
      self.stub!(:flash).and_return({message_type => "Error message"})
      node = Capybara.string display_flash_messages
      node.should have_css("div.alert-box.#{message_type}", :text => "Error message")
      node.should have_css("div.alert-box a.close", :text => "x")
      
    end
  end
  it "should use flash key matching" do
    self.stub!(:flash).and_return({:notice => "Error message"})
    node = Capybara.string display_flash_messages
    node.should have_css("div.alert-box.success")
  end
end