require 'spec_helper'

module GiveyRails
  describe AppliedRule do
    describe "#persisted?" do
      context "without an id" do
        it "returns false" do
          applied_rule = AppliedRule.new
          applied_rule.should_not be_persisted
        end
      end

      context "with an id" do
        it "returns true" do
          applied_rule = AppliedRule.new(id: 589)
          applied_rule.should be_persisted
        end
      end
    end

    describe "#created_at" do
      it "is an instance of DateTime" do
        applied_rule = AppliedRule.new(created_at: "2012-09-19T14:54:13Z")
        applied_rule.created_at.should be_kind_of DateTime
      end
    end

    describe "#donated_at" do
      it "is an instance of DateTime" do
        applied_rule = AppliedRule.new(donated_at: "2012-09-19T14:54:13Z")
        applied_rule.donated_at.should be_kind_of DateTime
      end
    end

    describe "#display_amount" do
      it "returns a Money object with a whole amount" do
        applied_rule = AppliedRule.new(amount: 100)
        applied_rule.display_amount.should == 1
      end
    end

  end
end
