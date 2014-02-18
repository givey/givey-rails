require 'spec_helper'

describe MeController do

  describe "check_its_me" do

    it "returns true if on a me page and signed_in" do
      controller.stub(:signed_in?).and_return(true)
      get :show
      response.code.should eq("200")
      response.body.should == "ME SHOW"
      controller.is_it_me?.should be_true
    end

    it "redirect if on a me page and not signed_in" do
      controller.stub(:signed_in?).and_return(false)
      get :show
      response.should redirect_to("/")
    end

  end

end
