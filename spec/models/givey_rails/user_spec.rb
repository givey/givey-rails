require 'spec_helper'

module GiveyRails
  describe User do
    it "has a default currency of GBP" do
      user = User.new
      user.currency.should == 'GBP'
    end
  end
end
