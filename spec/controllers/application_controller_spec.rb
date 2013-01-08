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

  describe "find_me" do

    it "should bring back the correct JSON for the find_me method" do
      application_controller.stub(:session).and_return({access_token: api_token})
      OAuth2::AccessToken.should_receive(:new).and_return(api_token)
      application_controller.access_token.stub_chain(:get, :body).and_return({this: 'that'}.to_json)
      application_controller.find_me.should == {"me" => 'info'}
    end

  end


end
