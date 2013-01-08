require 'spec_helper'

module GiveyRails
  describe Story do
    context "without id" do
      describe "#persisted?" do
        it "returns false" do
          story = Story.new 
          story.should_not be_persisted
        end
      end
    end
  end
end
