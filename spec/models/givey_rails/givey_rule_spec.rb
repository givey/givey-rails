require 'spec_helper'

module GiveyRails
  describe GiveyRule do
    it "exists" do
      givey_rule = GiveyRule.new
      givey_rule.should be_kind_of GiveyRule
    end
  end
end
