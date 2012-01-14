require "spec_helper"

describe "FoundationRailsHelper::FormHelper" do
  include FoundationRailsSpecHelper

  before do
    mock_everything
  end

  it 'should have FoundationRailsHelper::FormHelper as default buidler' do
    form_for(@author) do |builder|
      builder.class.should == FoundationRailsHelper::FormBuilder
    end    
  end
  
  it "should generate text_field input" do
    form_for(@author) do |builder|
      # Label
      builder.text_field(:login).should match(%r{<label class="" for="author_login">Login</label>})
      # Input class/type
      builder.text_field(:login).should match(%r{.*<input class="medium input-text placeholder".*type="text".*})
      # Input name/value
      builder.text_field(:login).should match(%r{.*<input.*name="author\[login\]".*value="#{@author.login}"})
    end    
  end
  
end
