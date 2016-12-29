# frozen_string_literal: true
require "spec_helper"

describe FoundationRailsHelper do
  describe FoundationRailsHelper::Configuration do
    describe "#button_class" do
      it "default value is 'success button'" do
        config = FoundationRailsHelper::Configuration.new
        expect(config.button_class).to eq("success button")
      end
    end

    describe "#button_class=" do
      it "can set value" do
        config = FoundationRailsHelper::Configuration.new
        config.button_class = "new-class"
        expect(config.button_class).to eq("new-class")
      end
    end

    describe "#ignored_flash_keys" do
      it "defaults to empty" do
        config = FoundationRailsHelper::Configuration.new
        expect(config.ignored_flash_keys).to eq([])
      end
    end

    describe "#ignored_flash_keys=" do
      it "can set the value" do
        config = FoundationRailsHelper::Configuration.new
        config.ignored_flash_keys = [:foo]
        expect(config.ignored_flash_keys).to eq([:foo])
      end
    end

    describe "#auto_labels" do
      it "default value is 'true'" do
        config = FoundationRailsHelper::Configuration.new
        expect(config.auto_labels).to be(true)
      end
    end

    describe "#auto_labels=" do
      it "can set the value" do
        config = FoundationRailsHelper::Configuration.new
        config.auto_labels = false
        expect(config.auto_labels).to be(false)
      end
    end

    describe ".reset" do
      it "resets the configured button class" do
        FoundationRailsHelper.configure do |config|
          config.button_class = "new-class"
        end

        FoundationRailsHelper.reset

        config = FoundationRailsHelper.configuration
        expect(config.button_class).to eq("success button")
      end

      it "resets the configured ignored flash keys" do
        FoundationRailsHelper.configure do |config|
          config.ignored_flash_keys = [:new_key]
        end

        FoundationRailsHelper.reset

        config = FoundationRailsHelper.configuration
        expect(config.ignored_flash_keys).to eq([])
      end

      it "resets the configured auto labels" do
        FoundationRailsHelper.configure do |config|
          config.auto_labels = false
        end

        FoundationRailsHelper.reset

        config = FoundationRailsHelper.configuration
        expect(config.auto_labels).to be(true)
      end
    end
  end
end
