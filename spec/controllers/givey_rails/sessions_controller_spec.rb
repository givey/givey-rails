require 'spec_helper'

describe GiveyRails::SessionsController do

  describe "GET /sign_in" do

    it "should assign a me object" do
      get :new
      assigns[:me].should be_kind_of(GiveyRails::User)
    end

  end

  describe "POST /sign_in" do

    it "should successfully login a user" do
      controller.stub(:params).and_return({me: {email: 'dave@dive.com', password: '12345'}})
      controller.should_receive(:set_password_token).with('dave@dive.com', '12345').and_return(true)
      post :create
      response.should redirect_to(root_path)
    end

    it "should fail to login a user" do
      pending
      #controller.stub(:params).and_return({me: {first_name: 'Doobie'}})
      #controller.stub(:post_token_response).with("/users", {user: {first_name: '#Doobie'}}).and_return({"errors" => []})
      #controller.should_receive(:set_password_token).never
      #post :create
      #response.should render_template(:new)
    end

  end


  describe "GET / DELETE /sign_out" do

    it "should successfully logout a user" do
      session[:user_id]       = '1234'
      session[:access_token]  = '0987'
      controller.access_token.stub(:get).with("/v1/oauth/revoke")
      get :destroy
      response.should redirect_to(root_path)
      session[:user_id].should be_nil
    end

  end



end
