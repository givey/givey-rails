require 'spec_helper'

module GiveyRails
  describe Story do

    include_context "reload models"

    it_behaves_like "a givey_rails model with attr_accessors"
    
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
