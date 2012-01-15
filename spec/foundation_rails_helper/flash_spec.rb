require "spec_helper"

describe "FoundationRailsHelper::FlashHelper" do
  include ActionView::Context if defined?(ActionView::Context)
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include FoundationRailsHelper::FlashHelper

  it "should display a flash" do
    self.stub!(:flash).and_return ({:error => "Error message"})
    node = Capybara.string display_flash
    puts display_flash
    node.should have_css('div.alert-box.error')
  end
end