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
      controller.stub(:params).and_return({me: {first_name: 'Doobie'}})
      controller.stub(:post_token_response).with("/users", {user: {first_name: 'Doobie'}}).and_return({"success" => true})
      controller.should_receive(:set_password_token)
      post :create
      response.should redirect_to(root_path)
      flash[:notice].should eq("User was successfully created.")
    end

    it "should fail to create a new user" do
      controller.stub(:params).and_return({me: {first_name: 'Doobie'}})
      controller.stub(:post_token_response).with("/users", {user: {first_name: 'Doobie'}}).and_return({"errors" => []})
      controller.should_receive(:set_password_token).never
      post :create
      response.should render_template(:new)
    end

  end


end
