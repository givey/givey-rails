require 'spec_helper'

module GiveyRails
  describe Business do

    it_behaves_like "a givey_rails model with attr_accessors"

    describe "#add_errors" do
      it "adds errors" do
        business = Business.new
        business.errors.should be_empty
        business.add_errors({'name' => ["can't be blank!"]})
        business.errors.should_not be_empty
      end
    end

  end
end
