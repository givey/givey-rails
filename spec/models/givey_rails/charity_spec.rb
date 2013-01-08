require 'spec_helper'

module GiveyRails
  describe Charity do
    describe "#name_and_tag" do
      it "concatenates name and tag" do
        charity = Charity.new(name: 'Heroes', givey_tag: "HERO")
        charity.name_and_tag.should == "HERO - Heroes"
      end
    end
  end
end
