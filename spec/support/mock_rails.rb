# frozen_string_literal: true
require 'bundler/setup'
require 'action_view'
require 'action_controller'
require 'active_model'
require 'active_support/core_ext'

# Thanks to Justin French for formtastic spec
module FoundationRailsSpecHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::DateHelper
  include ActionDispatch::Routing::UrlFor
  # to use dom_class in Rails 4 tests
  # in Rails 5, RecordIdentifier is already required by FormHelper module
  include ActionView::RecordIdentifier

  def active_model_validator(kind, attributes, options = {})
    validator = mock(
      "ActiveModel::Validations::#{kind.to_s.titlecase}Validator",
      attributes: attributes,
      options: options
    )
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

  def mock_everything
    mock_author
    mock_books
    mock_genres
  end

  # Resource-oriented styles like form_for(@post) will expect a path method
  # for the object, so we're defining some here.
  # the argument is required for Rails 4 tests
  def authors_path(*_args)
    '/authors'
  end

  def self.included(base)
    base.class_eval do
      attr_accessor :output_buffer

      def protect_against_forgery?
        false
      end
    end
  end

  private

  def mock_author
    @author = ::Author.new
    { login: 'fred_smith', email: 'fred@foo.com', url: 'http://example.com',
      some_number: '42', phone: '317 456 2564', active: true,
      description: 'bla bla bla', birthdate: DateTime.parse('1969-06-18 20:30'),
      forty_two:  DateTime.parse('1969-06-18 20:30') + 42.years,
      time_zone: 'Perth', publish_date: Date.new(2000, 1, 1),
      favorite_color: '#424242', favorite_book: nil }.each do |m, v|
      allow(@author).to receive(m).and_return(v)
    end
  end

  def mock_books
    mock_book_0
    mock_book_1
    allow(::Book).to receive(:all).and_return([@book_0, @book_1])
  end

  def mock_book_0
    @book_0 = ::Book.new
    allow(@book_0).to receive(:id).and_return('78')
    allow(@book_0).to receive(:title).and_return("Gulliver's Travels")
  end

  def mock_book_1
    @book_1 = ::Book.new
    allow(@book_1).to receive(:id).and_return('133')
    allow(@book_1).to receive(:title).and_return('Treasure Island')
  end

  def mock_genres
    mock_genre_0
    mock_genre_1
    allow(::Genre).to receive(:all).and_return([@genre_0, @genre_1])
  end

  def mock_genre_0
    @genre_0 = ::Genre.new
    allow(@genre_0).to receive(:name).and_return('Exploration')
    allow(@genre_0).to receive(:books).and_return([@book_0])
  end

  def mock_genre_1
    @genre_1 = ::Genre.new
    allow(@genre_1).to receive(:name).and_return('Pirate Exploits')
    allow(@genre_1).to receive(:books).and_return([@book_1])
  end
end
