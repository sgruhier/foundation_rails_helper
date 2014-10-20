require 'bundler/setup'
require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'action_dispatch'
require 'active_model'
require 'active_support/core_ext'

# Thanks to Justin French for formtastic spec
module FoundationRailsSpecHelper
  include ActionPack
  include ActionView::Context if defined?(ActionView::Context)
  include ActionView::RecordIdentifier
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
  include ActionDispatch::Routing::UrlFor

  def active_model_validator(kind, attributes, options = {})
    validator = mock("ActiveModel::Validations::#{kind.to_s.titlecase}Validator", :attributes => attributes, :options => options)
    allow(validator).to receive(:kind).and_return(kind)
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

  class ::Book
    extend ActiveModel::Naming if defined?(ActiveModel::Naming)
    include ActiveModel::Conversion if defined?(ActiveModel::Conversion)

    def to_label
    end

    def persisted?
    end
  end

  class ::Genre
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
    allow(@author).to receive(:class).and_return(::Author)
    allow(@author).to receive(:to_label).and_return('Fred Smith')
    allow(@author).to receive(:login).and_return('fred_smith')
    allow(@author).to receive(:email).and_return('fred@foo.com')
    allow(@author).to receive(:url).and_return('http://example.com')
    allow(@author).to receive(:some_number).and_return('42')
    allow(@author).to receive(:phone).and_return('317 456 2564')
    allow(@author).to receive(:password).and_return('secret')
    allow(@author).to receive(:active).and_return(true)
    allow(@author).to receive(:description).and_return('bla bla bla')
    allow(@author).to receive(:avatar).and_return('avatar.png')
    allow(@author).to receive(:birthdate).and_return(DateTime.parse("1969-06-18 20:30"))
    allow(@author).to receive(:id).and_return(37)
    allow(@author).to receive(:new_record?).and_return(false)
    allow(@author).to receive(:errors).and_return(mock('errors', :[] => nil))
    allow(@author).to receive(:to_key).and_return(nil)
    allow(@author).to receive(:persisted?).and_return(nil)
    allow(@author).to receive(:time_zone).and_return("Perth")
    allow(@author).to receive(:publish_date).and_return(Date.new( 2000, 1, 1 ))
    allow(@author).to receive(:forty_two).and_return(@author.birthdate + 42.years)
    allow(@author).to receive(:favorite_color).and_return("#424242")
    allow(@author).to receive(:favorite_book).and_return(nil)

    @book_0 = ::Book.new
    allow(@book_0).to receive(:id).and_return("78")
    allow(@book_0).to receive(:title).and_return("Gulliver's Travels")
    @book_1 = ::Book.new
    allow(@book_1).to receive(:id).and_return("133")
    allow(@book_1).to receive(:title).and_return("Treasure Island")
    @genre_0 = ::Genre.new
    allow(@genre_0).to receive(:name).and_return("Exploration")
    allow(@genre_0).to receive(:books).and_return([@book_0])
    @genre_1 = ::Genre.new
    allow(@genre_1).to receive(:name).and_return("Pirate Exploits")
    allow(@genre_1).to receive(:books).and_return([@book_1])

    allow(::Author).to receive(:scoped).and_return(::Author)
    allow(::Author).to receive(:find).and_return([@author])
    allow(::Author).to receive(:all).and_return([@author])
    allow(::Author).to receive(:where).and_return([@author])
    allow(::Author).to receive(:human_attribute_name) { |column_name| column_name.to_s.humanize }
    allow(::Author).to receive(:human_name).and_return('::Author')
    allow(::Author).to receive(:content_columns).and_return([mock('column', :name => 'login'), mock('column', :name => 'created_at')])
    allow(::Author).to receive(:to_key).and_return(nil)
    allow(::Author).to receive(:persisted?).and_return(nil)

    allow(::Book).to receive(:all).and_return([@book_0, @book_1])
    allow(::Genre).to receive(:all).and_return([@genre_0, @genre_1])
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
