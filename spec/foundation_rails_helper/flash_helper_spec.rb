# encoding: utf-8

require "spec_helper"

describe FoundationRailsHelper::FlashHelper do
  include ActionView::Context if defined?(ActionView::Context)
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include FoundationRailsHelper::FlashHelper

  FoundationRailsHelper::FlashHelper::DEFAULT_KEY_MATCHING.each do |message_type, foundation_type|
    it "displays flash message with #{foundation_type} class for #{message_type} message" do
      self.stub!(:flash).and_return({message_type => "Flash message"})
      node = Capybara.string display_flash_messages
      node.should have_css("div.alert-box.#{foundation_type}", :text => "Flash message")
      node.should have_css("div.alert-box a.close", :text => "×")
    end
  end

  it "displays flash message with overridden key matching" do
    self.stub!(:flash).and_return({:notice => "Flash message"})
    node = Capybara.string display_flash_messages({:notice => :alert})
    node.should have_css("div.alert-box.alert")
  end

  it "displays flash message with custom key matching" do
    self.stub!(:flash).and_return({:custom_type => "Flash message"})
    node = Capybara.string display_flash_messages({:custom_type => :custom_class})
    node.should have_css("div.alert-box.custom_class")
  end

  it "displays flash message with standard class if key doesn't match" do
    self.stub!(:flash).and_return({:custom_type => "Flash message"})
    node = Capybara.string display_flash_messages
    node.should have_css("div.alert-box.standard")
  end
end