require 'spec_helper'

describe GiveyRails::MeController do

  describe "GET /me/new" do

    it "should assign a me object" do
      get :new
      assigns[:me].should be_kind_of(GiveyRails::User)
    end

  end

  describe "POST /me" do

    it "should successfully create a new user" do
      controller.stub(:params).and_return({me: {first_name: 'Doobie', password: 'test', password_confirmation: 'test'}})
      controller.stub(:post_token_response).with("/users", {user: {first_name: 'Doobie', password: 'test', password_confirmation: 'test'}}).and_return({"success" => true})
      controller.should_receive(:set_password_token)
      post :create
      response.should redirect_to(root_path)
      flash[:notice].should eq("User was successfully created.")
    end

    it "should fail to create a new user" do
      controller.stub(:params).and_return({me: {first_name: 'Doobie', password: 'test', password_confirmation: 'test'}})
      controller.stub(:post_token_response).with("/users", {user: {first_name: 'Doobie', password: 'test', password_confirmation: 'test'}}).and_return({"errors" => []})
      controller.should_receive(:set_password_token).never
      post :create
      response.should render_template(:new)
    end

  end

  describe "GET /me/paypal_link" do

    it "should do the correct redirect" do
      controller.stub_chain(:access_token, :token).and_return('123sdf654')
      get :paypal_link
      response.status.should == 302
      response.header["Location"].should match(/paypal\/request_preapproval\?provider_redirect_url/)
    end

  end

  describe "GET /me/paypal_link_callback" do

    it "should redirect correctly" do
      get :paypal_link_callback
      response.should redirect_to(root_path)
      flash[:notice].should eq("PayPal account linked")
    end

  end


end
