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

  it "should display labels by default" do
    form_for(@author) do |builder|
      node = Capybara.string builder.text_field(:login)
      node.should have_css('label[for="author_login"]', :text => "Login")
    end
  end

  it "should not display labels by if there are options without auto_labels: false" do
    form_for(@author, {html: {class: 'myclass'}}) do |builder|
      node = Capybara.string builder.text_field(:login)
      node.should have_css('label[for="author_login"]', :text => "Login")
    end
  end

  it "should not display labels by if there are options without auto_labels: false" do
    form_for(@author, {html: {class: 'myclass'}, auto_labels: false}) do |builder|
      node = Capybara.string builder.text_field(:login)
      node.should_not have_css('label[for="author_login"]', :text => "Login")
    end
  end

  describe "input generators" do
    it "should generate text_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login)
        puts builder.text_field(:login)
        node.should have_css('label[for="author_login"]', :text => "Login")
        node.should have_css('input.medium.input-text[type="text"][name="author[login]"]')
        node.find_field('author_login').value.should == @author.login
      end
    end

    it "should generate text_field input without label" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login, :label => false)
        node.should_not have_css('label[for="author_login"]', :text => "Login")
        node.should have_css('input.medium.input-text[type="text"][name="author[login]"]')
        node.find_field('author_login').value.should == @author.login
      end
    end

    it "should generate password_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.password_field(:password)
        node.should have_css('label[for="author_password"]', :text => "Password")
        node.should have_css('input.medium.input-text[type="password"][name="author[password]"]')
        node.find_field('author_password').value.should be_nil
      end
    end

    it "should generate email_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.email_field(:email)
        node.should have_css('label[for="author_email"]', :text => "Email")
        node.should have_css('input.medium.input-text[type="email"][name="author[email]"]')
        node.find_field('author_email').value.should == @author.email
      end
    end

    it "should generate url_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.url_field(:url)
        node.should have_css('label[for="author_url"]', :text => "Url")
        node.should have_css('input.medium.input-text[type="url"][name="author[url]"]')
        node.find_field('author_url').value.should == @author.url
      end
    end

    it "should generate phone_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.phone_field(:phone)
        node.should have_css('label[for="author_phone"]', :text => "Phone")
        node.should have_css('input.medium.input-text[type="tel"][name="author[phone]"]')
        node.find_field('author_phone').value.should == @author.phone
      end
    end

    it "should generate number_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.number_field(:some_number)
        node.should have_css('label[for="author_some_number"]', :text => "Some number")
        node.should have_css('input.medium.input-text[type="number"][name="author[some_number]"]')
        node.find_field('author_some_number').value.should == @author.some_number
      end
    end

    it "should generate text_area input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_area(:description)
        node.should have_css('label[for="author_description"]', :text => "Description")
        node.should have_css('textarea.medium.input-text[name="author[description]"]')
        node.find_field('author_description').value.strip.should == @author.description
      end
    end

    it "should generate file_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.file_field(:avatar)
        node.should have_css('label[for="author_avatar"]', :text => "Avatar")
        node.should have_css('input.medium.input-text[type="file"][name="author[avatar]"]')
        node.find_field('author_avatar').value.should  be_nil
      end
    end

    it "should generate select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.select(:description, [["Choice #1", :a], ["Choice #2", :b]])
        node.should have_css('label[for="author_description"]', :text => "Description")
        node.should have_css('select[name="author[description]"]')
        node.should have_css('select[name="author[description]"] option[value="a"]', :text => "Choice #1")
        node.should have_css('select[name="author[description]"] option[value="b"]', :text => "Choice #2")
      end
    end

    it "should generate check_box input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.check_box(:active)
        node.should have_css('label[for="author_active"] input[type="hidden"][name="author[active]"][value="0"]')
        node.should have_css('label[for="author_active"] input[type="checkbox"][name="author[active]"]')
        node.should have_css('label[for="author_active"]', :text => "Active")
      end
    end
    it "should generate check_box input without a label" do
      form_for(@author) do |builder|
        node = Capybara.string builder.check_box(:active, :label => false)
        node.should have_css('input[type="hidden"][name="author[active]"][value="0"]')
        node.should have_css('input[type="checkbox"][name="author[active]"]')
        node.should_not have_css('label[for="author_active"]')
      end
    end

    it "should generate radio_button input" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.label(:active) + builder.radio_button(:active, "ok")
        node.should have_css('label[for="author_active_ok"] input[type="radio"][name="author[active]"]')
      end
    end

    it "should generate radio_button input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.radio_button(:active, true, text: "Functioning")
        node.should have_css('input[type="radio"][name="author[active]"]')
        node.should have_css('label[for="author_active_true"]', text: "Functioning")
      end
    end

    it 'should generate a radio button in the presence of extra attributes' do
      form_for(@author) do |builder|
        node = Capybara.string builder.radio_button(:active, true, text: "Functioning", required: true)
        node.should have_css('input[type="radio"][name="author[active]"]')
        node.should have_css('label[for="author_active_true"]', text: "Functioning")
      end
    end

    it "should generate date_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.date_select(:birthdate)
        node.should have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(1 2 3).each {|i| node.should     have_css("select.medium.input-text[name='author[birthdate(#{i}i)]']") }
        node.should have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        node.should have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        node.should have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        %w(4 5).each   {|i| node.should_not have_css("select.medium.input-text[name='author[birthdate(#{i}i)]']") }
      end
    end

    it "should generate date_select input with  :discard_year => true" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.date_select(:birthdate, :discard_year => true)
        node.should have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(2 3).each {|i| node.should     have_css("select.medium.input-text[name='author[birthdate(#{i}i)]']") }
        node.should_not have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        node.should have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        node.should have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        %w(1 4 5).each   {|i| node.should_not have_css("select.medium.input-text[name='author[birthdate(#{i}i)]']") }
      end
    end

    it "should generate datetime_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.datetime_select(:birthdate)
        node.should have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(1 2 3 4 5).each {|i| node.should     have_css("select.medium.input-text[name='author[birthdate(#{i}i)]']") }
        node.should have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        node.should have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        node.should have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        node.should have_css('select#author_birthdate_4i option[selected="selected"][value="20"]')
        node.should have_css('select#author_birthdate_5i option[selected="selected"][value="30"]')
      end
    end

    it "should generate datetime_select input with  :discard_year => true" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.datetime_select(:birthdate, :discard_year => true)
        node.should have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(2 3 4 5).each {|i| node.should     have_css("select.medium.input-text[name='author[birthdate(#{i}i)]']") }
        node.should_not have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        node.should have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        node.should have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        node.should have_css('select#author_birthdate_4i option[selected="selected"][value="20"]')
        node.should have_css('select#author_birthdate_5i option[selected="selected"][value="30"]')
        %w(1).each   {|i| node.should_not have_css("select.medium.input-text[name='author[birthdate(#{i}i)]']") }
      end
    end

    it "should generate time_zone_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:time_zone) + builder.time_zone_select(:time_zone)
        node.should have_css('label[for="author_time_zone"]', :text => "Time zone")
        node.should have_css('select[name="author[time_zone]"]')
        node.should have_css('select[name="author[time_zone]"] option[value="Perth"]', :text => "(GMT+08:00) Perth")
      end
    end

    it "should generate date_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.date_field(:publish_date)
        node.should have_css('label[for="author_publish_date"]', :text => "date")
        node.should have_css('input.medium.input-text[type="date"][name="author[publish_date]"]')
        node.find_field('author_publish_date').value.should == @author.publish_date.to_s
      end
    end

    it "should generate datetime_field input" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.datetime_field(:forty_two)
        node.should have_css('label[for="author_forty_two"]', :text => "Forty two")
        node.should have_css('input.medium.input-text[type="datetime"][name="author[forty_two]"]')
        value = DateTime.parse( node.find_field('author_forty_two').value)
        value.should == @author.forty_two.to_s
      end
    end

    it "should generate datetime_local_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.datetime_local_field(:forty_two)
        node.should have_css('label[for="author_forty_two"]', :text => "Forty two")
        node.should have_css('input.medium.input-text[type="datetime-local"][name="author[forty_two]"]')
        node.find_field('author_forty_two').value.should == @author.forty_two.strftime("%Y-%m-%dT%H:%M:%S")
      end
    end

    it "should generate month_field input" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.month_field(:forty_two)
        node.should have_css('label[for="author_forty_two"]', :text => "Forty two")
        node.should have_css('input.medium.input-text[type="month"][name="author[forty_two]"]')
        node.find_field('author_forty_two').value.should == @author.forty_two.strftime("%Y-%m")
      end
    end

    it "should generate week_field" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.week_field(:forty_two)
        node.should have_css('label[for="author_forty_two"]', :text => "Forty two")
        node.should have_css('input.medium.input-text[type="week"][name="author[forty_two]"]')
        node.find_field('author_forty_two').value.should == @author.forty_two.strftime("%Y-W%V")
      end
    end

    it "should generate time_field" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.time_field(:forty_two)
        node.should have_css('label[for="author_forty_two"]', :text => "Forty two")
        node.should have_css('input.medium.input-text[type="time"][name="author[forty_two]"]')
        node.find_field('author_forty_two').value.should == @author.forty_two.strftime("%H:%M:%S.%L")
      end
    end

    it "should generate range_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.range_field(:some_number)
        node.should have_css('label[for="author_some_number"]', :text => "Some number")
        node.should have_css('input.medium.input-text[type="range"][name="author[some_number]"]')
        node.find_field('author_some_number').value.should == @author.some_number
      end
    end

    it "should generate search_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.search_field(:description)
        node.should have_css('label[for="author_description"]', :text => "Description")
        node.should have_css('input.medium.input-text[type="search"][name="author[description]"]')
        node.find_field('author_description').value.should == @author.description
      end
    end

    it "should generate color_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.color_field(:favorite_color)
        node.should have_css('label[for="author_favorite_color"]', :text => "Favorite color")
        node.should have_css('input.medium.input-text[type="color"][name="author[favorite_color]"]')
        node.find_field('author_favorite_color').value.should == @author.favorite_color
      end
    end
  end

  describe "errors generator" do
    it "should not display errors" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login)
        node.should_not have_css('small.error')
      end
    end
    it "should display errors" do
      form_for(@author) do |builder|
        @author.stub!(:errors).and_return({:login => ['required']})
        node = Capybara.string builder.text_field(:login)
        node.should have_css('small.error', :text => "required")
      end
    end
    it "should display HTML errors when the option is specified" do
      form_for(@author) do |builder|
        @author.stub!(:errors).and_return({:login => ['required <a href="link_target">link</a>']})
        node = Capybara.string builder.text_field(:login, html_safe_errors: true)
        node.should have_link('link', href: 'link_target')
      end
    end
    it "should not display HTML errors when the option is not specified" do
      form_for(@author) do |builder|
        @author.stub!(:errors).and_return({:login => ['required <a href="link_target">link</a>']})
        node = Capybara.string builder.text_field(:login)
        node.should_not have_link('link', href: 'link')
      end
    end

    it "should not display labels unless specified in the builder method" do
      form_for(@author, auto_labels: false) do |builder|
        node = Capybara.string builder.text_field(:login) +
          builder.check_box(:active, label: true) +
          builder.text_field(:description, label: 'Tell me about you')

        node.should_not have_css('label[for="author_login"]')
        node.should have_css('label[for="author_active"]', text: 'Active')
        node.should have_css('label[for="author_description"]', text: 'Tell me about you')
      end
    end

  end
end
