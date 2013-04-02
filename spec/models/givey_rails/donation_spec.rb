require 'spec_helper'

module GiveyRails
  describe Donation do
    describe "#persisted?" do
      context "without an id" do
        it "returns false" do
          donation = Donation.new
          donation.should_not be_persisted
        end
      end

      context "with an id" do
        it "returns true" do
          donation = Donation.new(id: 589)
          donation.should be_persisted
        end
      end
    end

    describe "#created_at" do
      it "is an instance of DateTime" do
        donation = Donation.new(created_at: "2012-09-19T14:54:13Z")
        donation.created_at.should be_kind_of DateTime
      end
    end

    describe "#donated_at" do
      it "is an instance of DateTime" do
        donation = Donation.new(donated_at: "2012-09-19T14:54:13Z")
        donation.donated_at.should be_kind_of DateTime
      end
    end

    describe "#display_amount" do
      it "returns a Money object with a whole amount" do
        donation = Donation.new(amount: 100, currency: 'GBP')
        donation.display_amount.should == 1
      end
    end

    describe "#display_currency" do
      it "returns the relevant currency" do
        donation = Donation.new(amount: 100, currency: 'GBP')
        donation.display_currency.should == Money::Currency.new(:gbp)
      end
    end

    describe "#build_relationship" do
      donation = Donation.new(giver_target: { first_name: "Philip"})
      donation.giver_target.first_name.should == "Philip"
    end

    describe "#donation_string_html" do
      it "should render the correct string" do
        donation = Donation.new(donation_string_textile: '["(user).Joby":http://givey.com/JBMD] donated amt-usd1000-amt to ["(charity).MD Charity":http://givey.com/MDC]') 
        donation.donation_string_html.should == '<a href="http://givey.com/JBMD" class="user">Joby</a> donated $10 to <a href="http://givey.com/MDC" class="charity">MD Charity</a>'
      end

      it "should render the correct string - time donation" do
        donation = Donation.new(donation_string_textile: '["(user).Joby":http://givey.com/JBMD] donated time-3720-time to ["(charity).MD Charity":http://givey.com/MDC]') 
        donation.donation_string_html.should == '<a href="http://givey.com/JBMD" class="user">Joby</a> donated 1 hours and 2 minutes to <a href="http://givey.com/MDC" class="charity">MD Charity</a>'
      end
    end

    describe "#donation_images_html" do
      it "should render the correct string" do
        donation = Donation.new(donation_images_textile: ["!(user avatar)https://d3jpl91pxevbkh.cloudfront.net/givey/image/upload/c_fill,h_100,w_100/v1346148013/KICK-ASM548Big.jpg!"]) 
        donation.donation_images_html.should == '<img src="https://d3jpl91pxevbkh.cloudfront.net/givey/image/upload/c_fill,h_100,w_100/v1346148013/KICK-ASM548Big.jpg" class="user avatar" alt="" />'
      end
    end

  end
end
