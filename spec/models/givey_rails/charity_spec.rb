require 'spec_helper'

module GiveyRails
  describe Charity do

    include_context "reload models"

    it_behaves_like "a givey_rails model with attr_accessors"

    describe "correct accessors" do

      it "should have all the correct accessors" do
        charity = Charity.new
        charity_hash.keys.each do |charity_method|
          charity.should respond_to(charity_method)
        end
      end

    end

    describe "#name_and_tag" do
      it "concatenates name and tag" do
        charity = Charity.new(name: 'Heroes', givey_tag: "HERO")
        charity.name_and_tag.should == "HERO - Heroes"
      end
    end

    describe "#build_relationships" do
      let(:charity_response) do
        ActiveSupport::JSON.decode(
          File.read("#{ENGINE_RAILS_ROOT}/spec/fixtures/charity.json")
        )
      end

      context "with three donors" do
        describe "#donors" do
          it "builds an array of three users" do
            charity = Charity.new(charity_response)
            charity.donors.should have(3).items
            charity.donors.first.should be_kind_of(User)
          end
        end
      end

      context "with no supporters" do
        describe "#supporters" do
          it "returns nil" do
            charity = Charity.new(charity_response)
            charity.supporters.should be_nil
          end
        end
      end
    end

    describe "default currency" do

      it "has a default currency of GBP" do
        charity = Charity.new
        charity.currency.should == 'GBP'
      end

    end

    describe "charity_donations_total_display" do

      it "returns the correct amount" do
        charity = Charity.new(charity_donations_total: 1400)
        charity.charity_donations_total_display.should == 14
      end

    end

  end
end
