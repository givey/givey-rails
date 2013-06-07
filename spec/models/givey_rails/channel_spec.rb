require 'spec_helper'

module GiveyRails
  describe Channel do

    include_context "reload models"

    it_behaves_like "a givey_rails model with attr_accessors"

    describe "#name_and_tag" do
      it "concatenates tag and name" do
        channel = Channel.new(givey_tag: "HELP", name: "Help")
        channel.name_and_tag.should == "HELP - Help"
      end
    end

    describe "default currency" do

      it "has a default currency of GBP" do
        channel = Channel.new
        channel.currency.should == 'GBP'
      end

    end

    describe "charity_donations_total_display" do

      it "returns the correct amount" do
        channel = Channel.new(charity_donations_total: 1400)
        channel.charity_donations_total_display.should == 14
      end

    end
  end
end
