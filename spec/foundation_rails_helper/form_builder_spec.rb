require "spec_helper"

describe "FoundationRailsHelper::FormHelper" do
  include FoundationRailsSpecHelper

  before do
    mock_everything
  end

  it 'should have FoundationRailsHelper::FormHelper as default buidler' do
    form_for(@author) do |builder|
      expect(builder.class).to eq FoundationRailsHelper::FormBuilder
    end
  end

  it "should display labels by default" do
    form_for(@author) do |builder|
      node = Capybara.string builder.text_field(:login)
      expect(node).to have_css('label[for="author_login"]', :text => "Login")
    end
  end

  it "should not display labels by if there are options without auto_labels: false" do
    form_for(@author, {html: {class: 'myclass'}}) do |builder|
      node = Capybara.string builder.text_field(:login)
      expect(node).to have_css('label[for="author_login"]', :text => "Login")
    end
  end

  it "should not display labels by if there are options without auto_labels: false" do
    form_for(@author, {html: {class: 'myclass'}, auto_labels: false}) do |builder|
      node = Capybara.string builder.text_field(:login)
      expect(node).to_not have_css('label[for="author_login"]', :text => "Login")
    end
  end

  describe "label" do
    context "when there aren't any errors and no class option is passed" do
      it "should not have a class attribute" do
        form_for(@author) do |builder|
          node = Capybara.string builder.text_field(:login)
          expect(node).to have_css('label:not([class=""])')
        end        
      end
    end

    it "should not have error class multiple times" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:login => ['required']})
        node = Capybara.string builder.text_field(:login)
        error_class = node.find('label')['class'].split(/\s+/).keep_if { |v| v == 'error' }
        expect(error_class.size).to eq 1
      end  
    end
  end

  describe "input generators" do
    it "should generate text_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login)
        expect(node).to have_css('label[for="author_login"]', :text => "Login")
        expect(node).to have_css('input[type="text"][name="author[login]"]')
        expect(node.find_field('author_login').value).to eq @author.login
      end
    end

    it "should generate text_field input without label" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login, :label => false)
        expect(node).to_not have_css('label[for="author_login"]', :text => "Login")
        expect(node).to have_css('input[type="text"][name="author[login]"]')
        expect(node.find_field('author_login').value).to eq @author.login
      end
    end

    it "should generate text_field with class from options" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login, :class => 'righteous')
        expect(node).to have_css('input.righteous[type="text"][name="author[login]"]')
      end
    end

    it "should generate password_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.password_field(:password)
        expect(node).to have_css('label[for="author_password"]', :text => "Password")
        expect(node).to have_css('input[type="password"][name="author[password]"]')
        expect(node.find_field('author_password').value).to be_nil
      end
    end

    it "should generate email_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.email_field(:email)
        expect(node).to have_css('label[for="author_email"]', :text => "Email")
        expect(node).to have_css('input[type="email"][name="author[email]"]')
        expect(node.find_field('author_email').value).to eq @author.email
      end
    end

    it "should generate url_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.url_field(:url)
        expect(node).to have_css('label[for="author_url"]', :text => "Url")
        expect(node).to have_css('input[type="url"][name="author[url]"]')
        expect(node.find_field('author_url').value).to eq @author.url
      end
    end

    it "should generate phone_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.phone_field(:phone)
        expect(node).to have_css('label[for="author_phone"]', :text => "Phone")
        expect(node).to have_css('input[type="tel"][name="author[phone]"]')
        expect(node.find_field('author_phone').value).to eq @author.phone
      end
    end

    it "should generate number_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.number_field(:some_number)
        expect(node).to have_css('label[for="author_some_number"]', :text => "Some number")
        expect(node).to have_css('input[type="number"][name="author[some_number]"]')
        expect(node.find_field('author_some_number').value).to eq @author.some_number
      end
    end

    it "should generate text_area input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_area(:description)
        expect(node).to have_css('label[for="author_description"]', :text => "Description")
        expect(node).to have_css('textarea[name="author[description]"]')
        expect(node.find_field('author_description').value.strip).to eq @author.description
      end
    end

    it "should generate file_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.file_field(:avatar)
        expect(node).to have_css('label[for="author_avatar"]', :text => "Avatar")
        expect(node).to have_css('input[type="file"][name="author[avatar]"]')
        expect(node.find_field('author_avatar').value).to  be_nil
      end
    end

    it "should generate select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.select(:description, [["Choice #1", :a], ["Choice #2", :b]])
        expect(node).to have_css('label[for="author_description"]', :text => "Description")
        expect(node).to have_css('select[name="author[description]"]')
        expect(node).to have_css('select[name="author[description]"] option[value="a"]', :text => "Choice #1")
        expect(node).to have_css('select[name="author[description]"] option[value="b"]', :text => "Choice #2")
      end
    end

    it "should generate check_box input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.check_box(:active)
        expect(node).to have_css('label[for="author_active"] input[type="hidden"][name="author[active]"][value="0"]')
        expect(node).to have_css('label[for="author_active"] input[type="checkbox"][name="author[active]"]')
        expect(node).to have_css('label[for="author_active"]', :text => "Active")
      end
    end
    it "should generate check_box input without a label" do
      form_for(@author) do |builder|
        node = Capybara.string builder.check_box(:active, :label => false)
        expect(node).to have_css('input[type="hidden"][name="author[active]"][value="0"]')
        expect(node).to have_css('input[type="checkbox"][name="author[active]"]')
        expect(node).to_not have_css('label[for="author_active"]')
      end
    end

    it "should generate radio_button input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.radio_button(:active, "ok")
        expect(node).to have_css('label[for="author_active_ok"]')
        expect(node).to have_css('input[type="radio"][name="author[active]"]')
      end
    end
    it "should generate radio_button input with a label" do
      form_for(@author) do |builder|
        node = Capybara.string builder.radio_button(:active, true, label: "Functioning")
        expect(node).to have_css('label[for="author_active_true"]', text: "Functioning")
        expect(node).to have_css('input[type="radio"][name="author[active]"]')
      end
    end
    it "should generate radio_button without a label" do
      form_for(@author) do |builder|
        node = Capybara.string builder.radio_button(:active, "ok", label: false)
        expect(node).to_not have_css('label[for="author_active_ok"]')
        expect(node).to have_css('input[type="radio"][name="author[active]"]')
      end
    end
    it "should generate radio_button with label options" do
      form_for(@author) do |builder|
        node = Capybara.string builder.radio_button(:active, "ok", class: 'very', label_options: { class: 'special' })
        expect(node).to have_css('label.special[for="author_active_ok"]')
        expect(node).to have_css('input.very[type="radio"][name="author[active]"]')
      end
    end

    it "should generate date_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.date_select(:birthdate)
        expect(node).to have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(1 2 3).each {|i| expect(node).to     have_css("select[name='author[birthdate(#{i}i)]']") }
        expect(node).to have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        expect(node).to have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        expect(node).to have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        %w(4 5).each   {|i| expect(node).to_not have_css("select[name='author[birthdate(#{i}i)]']") }
      end
    end

    it "should generate date_select input with  :discard_year => true" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.date_select(:birthdate, :discard_year => true)
        expect(node).to have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(2 3).each {|i| expect(node).to     have_css("select[name='author[birthdate(#{i}i)]']") }
        expect(node).to_not have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        expect(node).to have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        expect(node).to have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        %w(1 4 5).each   {|i| expect(node).to_not have_css("select[name='author[birthdate(#{i}i)]']") }
      end
    end

    it "should generate datetime_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.datetime_select(:birthdate)
        expect(node).to have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(1 2 3 4 5).each {|i| expect(node).to     have_css("select[name='author[birthdate(#{i}i)]']") }
        expect(node).to have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        expect(node).to have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        expect(node).to have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        expect(node).to have_css('select#author_birthdate_4i option[selected="selected"][value="20"]')
        expect(node).to have_css('select#author_birthdate_5i option[selected="selected"][value="30"]')
      end
    end

    it "should generate datetime_select input with  :discard_year => true" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:birthdate) + builder.datetime_select(:birthdate, :discard_year => true)
        expect(node).to have_css('label[for="author_birthdate"]', :text => "Birthdate")
        %w(2 3 4 5).each {|i| expect(node).to     have_css("select[name='author[birthdate(#{i}i)]']") }
        expect(node).to_not have_css('select#author_birthdate_1i option[selected="selected"][value="1969"]')
        expect(node).to have_css('select#author_birthdate_2i option[selected="selected"][value="6"]')
        expect(node).to have_css('select#author_birthdate_3i option[selected="selected"][value="18"]')
        expect(node).to have_css('select#author_birthdate_4i option[selected="selected"][value="20"]')
        expect(node).to have_css('select#author_birthdate_5i option[selected="selected"][value="30"]')
        %w(1).each   {|i| expect(node).to_not have_css("select[name='author[birthdate(#{i}i)]']") }
      end
    end

    it "should generate time_zone_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.label(:time_zone) + builder.time_zone_select(:time_zone)
        expect(node).to have_css('label[for="author_time_zone"]', :text => "Time zone")
        expect(node).to have_css('select[name="author[time_zone]"]')
        expect(node).to have_css('select[name="author[time_zone]"] option[value="Perth"]', :text => "(GMT+08:00) Perth")
      end
    end

    it "should generate date_field input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.date_field(:publish_date)
        expect(node).to have_css('label[for="author_publish_date"]', :text => "date")
        expect(node).to have_css('input[type="date"][name="author[publish_date]"]')
        expect(node.find_field('author_publish_date').value).to eq @author.publish_date.to_s
      end
    end

    it "should generate datetime_field input" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.datetime_field(:forty_two)
        expect(node).to have_css('label[for="author_forty_two"]', :text => "Forty two")
        expect(node).to have_css('input[type="datetime"][name="author[forty_two]"]')
        value = DateTime.parse( node.find_field('author_forty_two').value)
        expect(value).to eq @author.forty_two.to_s
      end
    end

    it "should generate datetime_local_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.datetime_local_field(:forty_two)
        expect(node).to have_css('label[for="author_forty_two"]', :text => "Forty two")
        expect(node).to have_css('input[type="datetime-local"][name="author[forty_two]"]')
        expect(node.find_field('author_forty_two').value).to eq @author.forty_two.strftime("%Y-%m-%dT%H:%M:%S")
      end
    end

    it "should generate month_field input" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.month_field(:forty_two)
        expect(node).to have_css('label[for="author_forty_two"]', :text => "Forty two")
        expect(node).to have_css('input[type="month"][name="author[forty_two]"]')
        expect(node.find_field('author_forty_two').value).to eq @author.forty_two.strftime("%Y-%m")
      end
    end

    it "should generate week_field" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.week_field(:forty_two)
        expect(node).to have_css('label[for="author_forty_two"]', :text => "Forty two")
        expect(node).to have_css('input[type="week"][name="author[forty_two]"]')
        expect(node.find_field('author_forty_two').value).to eq @author.forty_two.strftime("%Y-W%V")
      end
    end

    it "should generate time_field" do
      form_for(@author) do |builder|
        node = Capybara.string  builder.time_field(:forty_two)
        expect(node).to have_css('label[for="author_forty_two"]', :text => "Forty two")
        expect(node).to have_css('input[type="time"][name="author[forty_two]"]')
        expect(node.find_field('author_forty_two').value).to eq @author.forty_two.strftime("%H:%M:%S.%L")
      end
    end

    it "should generate range_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.range_field(:some_number)
        expect(node).to have_css('label[for="author_some_number"]', :text => "Some number")
        expect(node).to have_css('input[type="range"][name="author[some_number]"]')
        expect(node.find_field('author_some_number').value).to eq @author.some_number
      end
    end

    it "should generate search_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.search_field(:description)
        expect(node).to have_css('label[for="author_description"]', :text => "Description")
        expect(node).to have_css('input[type="search"][name="author[description]"]')
        expect(node.find_field('author_description').value).to eq @author.description
      end
    end

    it "should generate color_field" do
      form_for(@author) do |builder|
        node = Capybara.string builder.color_field(:favorite_color)
        expect(node).to have_css('label[for="author_favorite_color"]', :text => "Favorite color")
        expect(node).to have_css('input[type="color"][name="author[favorite_color]"]')
        expect(node.find_field('author_favorite_color').value).to eq @author.favorite_color
      end
    end

    it "should generate collection_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.collection_select(:favorite_book, Book.all, :id, :title)
        expect(node).to have_css('label[for="author_favorite_book"]', :text => "Favorite book")
        expect(node).to have_css('select[name="author[favorite_book]"]')
        expect(node).to have_css('select[name="author[favorite_book]"] option[value="78"]', :text => "Gulliver's Travels")
        expect(node).to have_css('select[name="author[favorite_book]"] option[value="133"]', :text => "Treasure Island")
      end
    end

    it "should generate grouped_collection_select input" do
      form_for(@author) do |builder|
        node = Capybara.string builder.grouped_collection_select(:favorite_book, Genre.all, :books, :name, :id, :title)
        expect(node).to have_css('label[for="author_favorite_book"]', :text => "Favorite book")
        expect(node).to have_css('select[name="author[favorite_book]"]')
        expect(node).to have_css('select[name="author[favorite_book]"] optgroup[label="Exploration"] option[value="78"]', :text => "Gulliver's Travels")
        expect(node).to have_css('select[name="author[favorite_book]"] optgroup[label="Pirate Exploits"] option[value="133"]', :text => "Treasure Island")
      end
    end

    describe "hint" do
      it "should add a span element" do
        form_for(@author) do |builder|
          hint = 'Enter login'
          node = Capybara.string builder.text_field(:login, :hint => hint)
          p builder.text_field(:login, :hint => hint)
          expect(node.find("span").text).to eq hint
        end        
      end

      it "should not add hint attribute" do
        form_for(@author) do |builder|
          node = Capybara.string builder.text_field(:login, :hint => 'Enter login')
          expect(node.find_field("author_login")['hint']).to be_nil
        end
      end
    end
  end

  describe "errors generator" do
    it "should not display errors" do
      form_for(@author) do |builder|
        node = Capybara.string builder.text_field(:login)
        expect(node).to_not have_css('small.error')
      end
    end
    it "should display errors" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:login => ['required']})
        node = Capybara.string builder.text_field(:login)
        expect(node).to have_css('small.error', :text => "required")
      end
    end
    %w(file_field email_field text_field telephone_field phone_field
       url_field number_field date_field datetime_field datetime_local_field
       month_field week_field time_field range_field search_field color_field

       password_field
       ).each do |field|
      it "should display errors on #{field} inputs" do
        form_for(@author) do |builder|
          allow(@author).to receive(:errors).and_return({:description => ['required']})
          node = Capybara.string builder.public_send(field, :description)
          expect(node).to have_css('label.error[for="author_description"]')
          expect(node).to have_css('input.error[name="author[description]"]')
        end
      end
    end
    it "should display errors on text_area inputs" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:description => ['required']})
        node = Capybara.string builder.text_area(:description)
        expect(node).to have_css('label.error[for="author_description"]')
        expect(node).to have_css('textarea.error[name="author[description]"]')
      end
    end
    it "should display errors on select inputs" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:favorite_book => ['required']})
        node = Capybara.string builder.select(:favorite_book, [["Choice #1", :a], ["Choice #2", :b]])
        expect(node).to have_css('label.error[for="author_favorite_book"]')
        expect(node).to have_css('select.error[name="author[favorite_book]"]')
      end
    end
    it "should display errors on date_select inputs" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:birthdate => ['required']})
        node = Capybara.string builder.date_select(:birthdate)
        expect(node).to have_css('label.error[for="author_birthdate"]')
        %w(1 2 3).each {|i| expect(node).to have_css("select.error[name='author[birthdate(#{i}i)]']") }
      end
    end
    it "should display errors on datetime_select inputs" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:birthdate => ['required']})
        node = Capybara.string builder.datetime_select(:birthdate)
        expect(node).to have_css('label.error[for="author_birthdate"]')
        %w(1 2 3 4 5).each {|i| expect(node).to have_css("select.error[name='author[birthdate(#{i}i)]']") }
      end
    end
    it "should display errors on time_zone_select inputs"  do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:time_zone => ['required']})
        node = Capybara.string builder.time_zone_select(:time_zone)
        expect(node).to have_css('label.error[for="author_time_zone"]')
        expect(node).to have_css('select.error[name="author[time_zone]"]')
      end
    end

    it "should display errors on collection_select inputs" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:favorite_book => ['required']})
        node = Capybara.string builder.collection_select(:favorite_book, Book.all, :id, :title)
        expect(node).to have_css('label.error[for="author_favorite_book"]')
        expect(node).to have_css('select.error[name="author[favorite_book]"]')
      end
    end

    it "should display errors on grouped_collection_select inputs" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:favorite_book => ['required']})
        node = Capybara.string builder.grouped_collection_select(:favorite_book, Genre.all, :books, :name, :id, :title)
        expect(node).to have_css('label.error[for="author_favorite_book"]')
        expect(node).to have_css('select.error[name="author[favorite_book]"]')
      end
    end

    # N.B. check_box and radio_button inputs don't have the error class applied

    it "should display HTML errors when the option is specified" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:login => ['required <a href="link_target">link</a>']})
        node = Capybara.string builder.text_field(:login, html_safe_errors: true)
        expect(node).to have_link('link', href: 'link_target')
      end
    end
    it "should not display HTML errors when the option is not specified" do
      form_for(@author) do |builder|
        allow(@author).to receive(:errors).and_return({:login => ['required <a href="link_target">link</a>']})
        node = Capybara.string builder.text_field(:login)
        expect(node).to_not have_link('link', href: 'link')
      end
    end

    it "should not display labels unless specified in the builder method" do
      form_for(@author, auto_labels: false) do |builder|
        node = Capybara.string builder.text_field(:login) +
          builder.check_box(:active, label: true) +
          builder.text_field(:description, label: 'Tell me about you')

        expect(node).to_not have_css('label[for="author_login"]')
        expect(node).to have_css('label[for="author_active"]', text: 'Active')
        expect(node).to have_css('label[for="author_description"]', text: 'Tell me about you')
      end
    end

    context 'when class option given' do
      it "should add it to the error class" do
        form_for(@author) do |builder|
          allow(@author).to receive(:errors).and_return({:email => ['required']})
          node = Capybara.string builder.text_field(:email, class: 'righteous')
          expect(node).to have_css('input.righteous.error[name="author[email]"]')
        end
      end
    end

    context 'when invalid class option given' do
      it "should add it to the error class" do
        form_for(@author) do |builder|
          allow(@author).to receive(:errors).and_return({:email => ['required']})
          node = Capybara.string builder.text_field(:email, class: :illgotten)
          expect(node).to have_css('input.illgotten.error[name="author[email]"]')
        end
      end
    end
  end

  describe 'submit button generator' do
    after :each do
      FoundationRailsHelper.reset
    end

    context 'when button_class config is not set' do
      it "should display form button with default class" do
        form_for(@author) do |builder|
          node = Capybara.string builder.submit('Save')
          expect(node).to have_css('input[type="submit"][class="small radius success button"]')
        end
      end
    end

    context 'when button_class config is "superduper"' do
      before do
        FoundationRailsHelper.configure do |config|
          config.button_class = 'superduper'
        end
      end

      it "should display form button with 'superduper' class" do
        form_for(@author) do |builder|
          node = Capybara.string builder.submit('Save')
          expect(node).to have_css('input[type="submit"][class="superduper"]')
        end
      end
    end

    context 'when option value is "superduper"' do
      it "should display form button with 'superduper' class" do
        form_for(@author) do |builder|
          node = Capybara.string builder.submit('Save', class: 'superduper')
          expect(node).to have_css('input[type="submit"][class="superduper"]')
        end
      end
    end
  end
end
