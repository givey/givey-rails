require 'spec_helper'

module GiveyRails
  describe Business do

    include_context "reload models"

    it_behaves_like "a givey_rails model with attr_accessors"

    describe "#add_errors" do
      it "adds errors" do
        business = Business.new
        business.errors.should be_empty
        business.add_errors({'name' => ["can't be blank!"]})
        business.errors.should_not be_empty
      end
    end

    describe "#paypal?" do
      context "when approved" do
        business = Business.new(ppx_status: 'approved')
        business.paypal?.should == true
      end

      context "when not approved" do
        business = Business.new(ppx_status: 'not_approved')
        business.paypal?.should == false
      end
    end

    describe "the cache fields" do
      it "should recognise fields with cache in the name" do
        business = Business.new(match_total_cache: {})
        business.match_total_cache.should == {}
      end
    end

  end
end
