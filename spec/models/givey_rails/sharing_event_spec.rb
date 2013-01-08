require 'spec_helper'

module GiveyRails
  describe SharingEvent do
    describe "#givey_token" do
      sharing_event = SharingEvent.new
      sharing_event.givey_token.should == nil
    end
  end
end
