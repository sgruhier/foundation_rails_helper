# frozen_string_literal: true
module FoundationRailsHelper
  class SizeClassCalculator
    def initialize(size_options)
      @small = size_options[:small]
      @medium = size_options[:medium]
      @large = size_options[:large]
    end

    def classes
      [small_class, medium_class, large_class].compact.join(' ')
    end

    private

    def small_class
      "small-#{@small}" if valid_size(@small)
    end

    def medium_class
      "medium-#{@medium}" if valid_size(@medium)
    end

    def large_class
      "large-#{@large}" if valid_size(@large)
    end

    def valid_size(value)
      value.present? && value.to_i < 12
    end
  end
end
