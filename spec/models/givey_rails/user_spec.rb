require 'spec_helper'

module GiveyRails

  describe User do

    include_context "reload models"

    it_behaves_like "a givey_rails model with attr_accessors"

    it "should have all the correct accessors" do
      me_hash.keys.each do |method_from_json_key|
        User.new.should respond_to(method_from_json_key)
      end
    end

    it "has a default currency of GBP" do
      user = User.new
      user.currency.should == 'GBP'
    end

    it "has an id method" do
      user  = User.new
      user.should respond_to(:id)
    end

    it "accepts an id attribute" do
      user  = User.new({"id" => "123049"})
      user.id.should == "123049"
    end

    it "accepts an id attribute - symbol" do
      user  = User.new({id: "123049"})
      user.id.should == "123049"
    end

    it "returns a new address if no addresses present" do
      user  = User.new
      user.addresses.first.should be_kind_of(GiveyRails::Address)
    end

    it "returns a new address if empty addresses returned by API" do
      user  = User.new(user_hash.merge(addresses: []))
      user.addresses.first.should be_kind_of(GiveyRails::Address)
    end

    describe "business_state" do
      
       it "should return 'none' if the user has no business" do
         user = User.new(user_hash.merge(business: nil))
         user.business_state.should == "none"
       end

       it "should return 'pending' if the user has not confirmed their business" do
         user = User.new(user_hash.merge(business_confirmed: false))
         user.business_state.should == "pending"
       end

       it "should return 'attached' if the user has a business but no employee match" do
         user = User.new(user_hash.merge(employee_match_exists: false, employee_target_match_exists: false))
         user.business_state.should == "attached"
       end

       it "should return 'employee_match' if the user has a business and an employee match" do
         user = User.new(user_hash.merge(employee_match_exists: true, employee_target_match_exists: false))
         user.business_state.should == "employee_match"
       end

       it "should return 'employee_target_match' if the user has a business and a fundraise match" do
         user = User.new(user_hash.merge(employee_match_exists: false, employee_target_match_exists: true))
         user.business_state.should == "employee_target_match"
       end

       it "should return 'all_match' if the user has a business, an employee match and a fundraise match" do
         user = User.new(user_hash.merge(employee_match_exists: true, employee_target_match_exists: true))
         user.business_state.should == "all_match"
       end

    end

  end
end
