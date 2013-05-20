
require 'spec_helper'

module GiveyRails
  describe RecurringDonation do

    include_context "reload models"

    it_behaves_like "a givey_rails model with attr_accessors"

    describe "#persisted?" do
      context "without an id" do
        it "returns false" do
          donation = RecurringDonation.new
          donation.should_not be_persisted
        end
      end

      context "with an id" do
        it "returns true" do
          donation = RecurringDonation.new(id: 589)
          donation.should be_persisted
        end
      end
    end

    describe "#created_at" do
      it "is an instance of DateTime" do
        donation = RecurringDonation.new(created_at: "2012-09-19T14:54:13Z")
        donation.created_at.should be_kind_of DateTime
      end
    end

    describe "#display_amount" do
      it "returns a Money object with a whole amount" do
        donation = RecurringDonation.new(amount: 100, currency: 'GBP')
        donation.display_amount.should == 1
      end
    end

    describe "#display_currency" do
      it "returns the relevant currency" do
        donation = RecurringDonation.new(amount: 100, currency: 'GBP')
        donation.display_currency.should == Money::Currency.new(:gbp)
      end
    end

  end
end
