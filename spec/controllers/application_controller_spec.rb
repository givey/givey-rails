require 'spec_helper'

describe ApplicationController do

  GiveyRuby.configure do |config|
    config.client({token_file: "#{SPEC_ROOT}/support/givey_token_file"})
  end

  let(:application_controller) { ApplicationController.new }
  let(:api_token)              { '123sdf21' }

  describe "signed_in?" do

    it "should show that the user is signed in" do
      application_controller.stub(:session).and_return({user_id: '123456'})
      application_controller.signed_in?.should be_true
    end

  end

  describe "current_givey_user" do

    it "should bring back the correct JSON for the current_givey_user method" do
      application_controller.stub(:session).and_return({access_token: api_token})
      OAuth2::AccessToken.should_receive(:new).and_return(api_token)
      application_controller.access_token.stub_chain(:get, :body).and_return({givey_tag: 'VOID'}.to_json)
      application_controller.current_givey_user.givey_tag.should == "VOID"
    end

  end

  describe "is_it_me?" do

    it "should be true for path /me/show" do
      application_controller.stub_chain(:request, :fullpath).and_return("/me/show")
      application_controller.is_it_me?.should be_true
    end

    it "should be true for path /me" do
      application_controller.stub_chain(:request, :fullpath).and_return("/me")
      application_controller.is_it_me?.should be_true
    end

    it "should be false for path /user/show" do
      application_controller.stub_chain(:request, :fullpath).and_return("/user/show")
      application_controller.is_it_me?.should be_false
    end

    it "should be false for path /meteor" do
      # no false positive
      application_controller.stub_chain(:request, :fullpath).and_return("/meteor")
      application_controller.is_it_me?.should be_false
    end

  end

  describe "givey_user" do

    it "should bring back the correct JSON for the current_user if me path" do
      application_controller.stub(:signed_in?).and_return(true)
      application_controller.stub_chain(:request, :fullpath).and_return("/me/show")
      application_controller.stub(:get_token_response).with("/me").and_return({givey_tag: 'VOID'})
      application_controller.givey_user.givey_tag.should == "VOID"
    end

    it "should bring back the correct JSON for the other if not me path" do
      application_controller.stub_chain(:request, :fullpath).and_return("/other/index")
      application_controller.stub(:params).and_return({user_id: "1234"})
      application_controller.stub(:get_token_response).with("/users/1234").and_return({givey_tag: 'OTHER'})
      application_controller.givey_user.givey_tag.should == "OTHER"
    end

    it "should bring back nil for other states" do
      application_controller.stub_chain(:request, :fullpath).and_return("/other/index")
      application_controller.stub(:params).and_return({})
      application_controller.givey_user.should == nil
    end

  end

  describe "set_referrer" do

    it "should set the session referrer to a specified URL" do
      application_controller.stub(:session).and_return({})
      application_controller.set_referrer("/this/that")
      application_controller.session[:referrer] = "/this/that"
    end

  end

end
