require 'spec_helper'

module GiveyRails
  describe Address do

    it "should have all the correct accessors" do
      me_hash.addresses.first.address.keys.each do |method_from_json_key|
        Address.new.should respond_to(method_from_json_key)
      end
    end

    it "has a city" do
      address = Address.new(city: "London")
      address.city.should == "London"
    end
  end
end
