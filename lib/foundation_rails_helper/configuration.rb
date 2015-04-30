module FoundationRailsHelper
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :button_class
    attr_accessor :ignored_flash_keys

    def initialize
      @button_class = 'small radius success button'
      @ignored_flash_keys = []
    end
  end
end
