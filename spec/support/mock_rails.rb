require 'rails'
require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'action_dispatch'

# Thanks to Justin French for formtastic spec
module FoundationRailsSpecHelper
  include ActionPack
  include ActionView::Context if defined?(ActionView::Context)
  include ActionController::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper if defined?(ActionView::Helpers::ActiveRecordHelper)
  include ActionView::Helpers::ActiveModelHelper if defined?(ActionView::Helpers::ActiveModelHelper)
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  include ActiveSupport
  include ActionController::PolymorphicRoutes if defined?(ActionController::PolymorphicRoutes)

  def active_model_validator(kind, attributes, options = {})
    validator = mock("ActiveModel::Validations::#{kind.to_s.titlecase}Validator", :attributes => attributes, :options => options)
    validator.stub!(:kind).and_return(kind)
    validator
  end

  def active_model_presence_validator(attributes, options = {})
    active_model_validator(:presence, attributes, options)
  end

  def active_model_length_validator(attributes, options = {})
    active_model_validator(:length, attributes, options)
  end

  def active_model_inclusion_validator(attributes, options = {})
    active_model_validator(:inclusion, attributes, options)
  end

  def active_model_numericality_validator(attributes, options = {})
    active_model_validator(:numericality, attributes, options)
  end

  class ::Author
    extend ActiveModel::Naming if defined?(ActiveModel::Naming)
    include ActiveModel::Conversion if defined?(ActiveModel::Conversion)

    def to_label
    end

    def persisted?
    end
  end

  def mock_everything
    # Resource-oriented styles like form_for(@post) will expect a path method for the object,
    # so we're defining some here.
    def author_path(*args); "/authors/1"; end
    def authors_path(*args); "/authors"; end
    def new_author_path(*args); "/authors/new"; end

    @author = ::Author.new
    @author.stub!(:class).and_return(::Author)
    @author.stub!(:to_label).and_return('Fred Smith')
    @author.stub!(:login).and_return('fred_smith')
    @author.stub!(:email).and_return('fred@foo.com')
    @author.stub!(:url).and_return('http://example.com')
    @author.stub!(:some_number).and_return('42')
    @author.stub!(:phone).and_return('317 456 2564')
    @author.stub!(:password).and_return('secret')
    @author.stub!(:active).and_return(true)
    @author.stub!(:description).and_return('bla bla bla')
    @author.stub!(:avatar).and_return('avatar.png')
    @author.stub!(:birthdate).and_return(Date.parse("1969-06-18 20:30"))
    @author.stub!(:id).and_return(37)
    @author.stub!(:new_record?).and_return(false)
    @author.stub!(:errors).and_return(mock('errors', :[] => nil))
    @author.stub!(:to_key).and_return(nil)
    @author.stub!(:persisted?).and_return(nil)

    ::Author.stub!(:scoped).and_return(::Author)
    ::Author.stub!(:find).and_return([@author])
    ::Author.stub!(:all).and_return([@author])
    ::Author.stub!(:where).and_return([@author])
    ::Author.stub!(:human_attribute_name).and_return { |column_name| column_name.to_s.humanize }
    ::Author.stub!(:human_name).and_return('::Author')
    ::Author.stub!(:content_columns).and_return([mock('column', :name => 'login'), mock('column', :name => 'created_at')])
    ::Author.stub!(:to_key).and_return(nil)
    ::Author.stub!(:persisted?).and_return(nil)
  end

  def self.included(base)
    base.class_eval do
      attr_accessor :output_buffer

      def protect_against_forgery?
        false
      end

    end
  end
end
