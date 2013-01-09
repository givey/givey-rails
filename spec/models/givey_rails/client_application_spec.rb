require 'spec_helper'

module GiveyRails
  describe ClientApplication do
    context "without an id" do
      describe "#persisted?" do
        it "returns false" do
          client_application = ClientApplication.new
          client_application.should_not be_persisted
        end
      end
    end
  end
end
