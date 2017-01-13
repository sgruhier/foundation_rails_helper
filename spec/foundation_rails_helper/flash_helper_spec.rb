# frozen_string_literal: true
require "spec_helper"

describe FoundationRailsHelper::FlashHelper do
  include ActionView::Context if defined?(ActionView::Context)
  include ActionView::Helpers::FormTagHelper
  include FoundationRailsHelper::FlashHelper

  KEY_MATCHING = FoundationRailsHelper::FlashHelper::DEFAULT_KEY_MATCHING.freeze

  KEY_MATCHING.each do |type, klass|
    it "displays flash message with #{klass} class for #{type} message" do
      allow(self).to receive(:flash).and_return(type.to_s => "Flash message")
      node = Capybara.string display_flash_messages
      expect(node)
        .to  have_css("div.flash.callout.#{klass}", text: "Flash message")
        .and have_css("[data-close]", text: "×")
    end
  end

  it "handles symbol keys" do
    allow(self).to receive(:flash).and_return(success: "Flash message")
    node = Capybara.string display_flash_messages
    expect(node).to have_css("div.callout.success", text: "Flash message")
  end

  it "handles string keys" do
    allow(self).to receive(:flash).and_return("success" => "Flash message")
    node = Capybara.string display_flash_messages
    expect(node).to have_css("div.callout.success", text: "Flash message")
  end

  it "displays multiple flash messages" do
    allow(self).to receive(:flash)
      .and_return("success" => "Yay it worked",
                  "error" => "But this other thing failed")
    node = Capybara.string display_flash_messages
    expect(node)
      .to  have_css("div.callout.success", text: "Yay it worked")
      .and have_css("div.callout.alert",   text: "But this other thing failed")
  end

  it "displays flash message with overridden key matching" do
    allow(self).to receive(:flash).and_return("notice" => "Flash message")
    node =
      Capybara.string display_flash_messages(key_matching: { notice: :alert })
    expect(node).to have_css("div.callout.alert", text: "Flash message")
  end

  it "displays flash message with custom key matching" do
    allow(self).to receive(:flash).and_return("custom_type" => "Flash message")
    node = Capybara.string(
      display_flash_messages(key_matching: { custom_type: :custom_class })
    )
    expect(node).to have_css("div.callout.custom_class", text: "Flash message")
  end

  it "displays flash message with standard class if key doesn't match" do
    allow(self).to receive(:flash).and_return("custom_type" => "Flash message")
    node = Capybara.string display_flash_messages
    expect(node).to have_css("div.callout.primary", text: "Flash message")
  end

  context "when the flash hash contains devise internal data" do
    before do
      FoundationRailsHelper.configure do |config|
        config.ignored_flash_keys += [:timedout]
      end
    end

    it "doesn't raise an error (e.g. NoMethodError)" do
      allow(self).to receive(:flash).and_return("timedout" => true)
      expect { Capybara.string display_flash_messages }.not_to raise_error
    end

    it "doesn't display an alert for that data" do
      allow(self).to receive(:flash).and_return("timedout" => true)
      expect(display_flash_messages).to be_nil

      # Ideally we'd create a node using Capybara.string, as in the other
      # examples and set the following expectation:
      #   expect(node).to_not have_css("div.callout")
      # but Capybara.string doesn't behave nicely with nil input:
      # the input gets assigned to the @native instance variable,
      # which is used by the css matcher, so we get the following error:
      #   undefined method `css' for nil:NilClass
    end
  end

  context "with (closable: false) option" do
    it "doesn't display the close button" do
      allow(self).to receive(:flash).and_return(success: "Flash message")
      node = Capybara.string display_flash_messages(closable: false)
      expect(node)
        .to  have_css("div.flash.callout.success", text: "Flash message")
        .and have_no_css("[data-close]", text: "×")
    end
  end
end
