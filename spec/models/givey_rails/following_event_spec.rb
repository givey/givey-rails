require 'spec_helper'

module GiveyRails
  describe FollowingEvent do
    context "without an id" do
      describe "#persisted?" do
        it "returns false" do
          following_event = FollowingEvent.new
          following_event.should_not be_persisted
        end
      end
    end
  end
end
