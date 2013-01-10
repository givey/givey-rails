require 'spec_helper'

module GiveyRails
  describe Charity do
    describe "#name_and_tag" do
      it "concatenates name and tag" do
        charity = Charity.new(name: 'Heroes', givey_tag: "HERO")
        charity.name_and_tag.should == "HERO - Heroes"
      end
    end

    describe "#build_relationships" do
      let(:charity_response) do
        ActiveSupport::JSON.decode(
          File.read("#{ENGINE_RAILS_ROOT}/spec/fixtures/charity.json")
        )
      end

      context "with three donors" do
        describe "#donors" do
          it "builds an array of three users" do
            charity = Charity.new(charity_response)
            charity.donors.should have(3).items
            charity.donors.first.should be_kind_of(User)
          end
        end
      end

      context "with no supporters" do
        describe "#supporters" do
          it "returns nil" do
            charity = Charity.new(charity_response)
            charity.supporters.should be_nil
          end
        end
      end
    end
  end
end
