require 'spec_helper'

module GiveyRails
  describe Address do
    it "has a city" do
      address = Address.new(city: "London")
      address.city.should == "London"
    end
  end
end
