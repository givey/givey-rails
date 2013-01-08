require 'spec_helper'

describe ApplicationController do

  GiveyRuby.configure do |config|
    config.client({token_file: "#{SPEC_ROOT}/support/givey_token_file"})
  end

  describe "signed_in?" do

    let(:application_controller) { ApplicationController.new }


    it "should show " do
      application_controller.stub(:session).and_return({user_id: '123456'})
      application_controller.signed_in?.should be_true
    end

  end

end
