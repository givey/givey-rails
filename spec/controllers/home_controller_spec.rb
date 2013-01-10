require 'spec_helper'

describe HomeController do

  GiveyRuby.configure do |config|
    config.client({token_file: "#{SPEC_ROOT}/support/givey_token_file"})
  end

  describe "check_user_signed_in" do

    it "checks if a user is signed in and returns 200" do
      controller.stub(:signed_in?).and_return(true)
      get :protected
      response.code.should eq("200")
      response.body.should == "PROTECTED"
    end

    it "checks if a user is signed in and redirects if not" do
      controller.stub(:signed_in?).and_return(false)
      get :protected
      response.should redirect_to("/sign_in")
    end

  end

  describe "is_it_me?" do

    it "returns false if on a non-me page" do
      get :index
      controller.is_it_me?.should be_false
    end

  end

  describe "redirect_to_referrer" do

    it "should redirect to session referrer if set" do
      controller.stub(:session).and_return({referrer: '/this/that'})
      get :redirected
      response.should redirect_to("/this/that")
    end

    it "should redirect to root_path if referrer set" do
      controller.stub(:session).and_return({})
      get :redirected
      response.should redirect_to("/")
    end

  end


end
