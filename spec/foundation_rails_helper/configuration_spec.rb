require 'spec_helper'

describe FoundationRailsHelper do

  describe FoundationRailsHelper::Configuration do
    describe "#button_class" do
      it "default value is 'small radius success button'" do
        config = FoundationRailsHelper::Configuration.new
        expect(config.button_class).to eq('small radius success button')
      end
    end

    describe "#button_class=" do
      it "can set value" do
        config = FoundationRailsHelper::Configuration.new
        config.button_class = 'new-class'
        expect(config.button_class).to eq('new-class')
      end
    end

    describe ".reset" do
      before :each do
        FoundationRailsHelper.configure do |config|
          config.button_class = 'new-class'
        end
      end

      it "resets the configuration" do
        FoundationRailsHelper.reset

        config = FoundationRailsHelper.configuration

        expect(config.button_class).to eq('small radius success button')
      end
    end
  end

end
