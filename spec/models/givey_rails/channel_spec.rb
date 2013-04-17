require 'spec_helper'

module GiveyRails
  describe Channel do

    it_behaves_like "a givey_rails model with attr_accessors"

    describe "#name_and_tag" do
      it "concatenates tag and name" do
        channel = Channel.new(givey_tag: "HELP", name: "Help")
        channel.name_and_tag.should == "HELP - Help"
      end
    end
  end
end
