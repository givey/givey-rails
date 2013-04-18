require 'spec_helper'

module GiveyRails
  describe User do

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

  end
end
