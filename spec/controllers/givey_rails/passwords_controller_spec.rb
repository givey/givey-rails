require 'spec_helper'

describe GiveyRails::PasswordsController do

  describe "GET /password/new" do

    it "should assign a user object" do
      session[:access_token] = '1234'
      get :new
      assigns[:user].should be_kind_of(GiveyRails::User)
      session[:access_token].should be_nil
    end

  end

  describe "POST /password" do

    it "should successfully send a reset email" do
      controller.should_receive(:post_token_response).with("/users/password", user: {"email" => 'dave@dive.com', "password_reset_url" => "http://test.host/password/edit"}).and_return("id" => "1234")
      post :create, user: {email: 'dave@dive.com'}
      response.should redirect_to(new_password_path)
      flash[:notice].should == "Your password reset instructions have been sent"
    end

    it "should fail to send a reset email" do
      controller.should_receive(:post_token_response).with("/users/password", user: {"email" => 'dave@dive.com', "password_reset_url" => "http://test.host/password/edit"}).and_return("message" => "not found")
      post :create, user: {email: 'dave@dive.com'}
      response.should redirect_to(new_password_path)
      flash[:notice].should == "We could not find a user with that email address"
    end

  end

  describe "GET /password/edit" do

    it "should assign a user object found from reset_password_token" do
      user = mock('GiveyRails::User')
      GiveyRails::User.should_receive(:new).with(reset_password_token: '1234').and_return(user)
      get :edit, reset_password_token: '1234'
      assigns[:user].should == user
    end

  end

  describe "PUT /password" do

    it "should successfully reset a password" do
      controller.should_receive(:put_token_response).with("/users/password", user: {"email" => 'dave@dive.com', "reset_password_token" => '1234', "password" => 'password', "password_confirmation" => 'password'}).and_return("token" => "1234")
      controller.should_receive(:login_token_user).with("1234")
      put :update, user: {"email" => 'dave@dive.com', "reset_password_token" => '1234', "password" => 'password', "password_confirmation" => 'password'}
      response.should redirect_to(root_path)
      flash[:notice].should == "Your password has been reset"
    end

    it "should fail to reset a password" do
      controller.should_receive(:put_token_response).with("/users/password", user: {"email" => 'dave@dive.com', "reset_password_token" => '1234', "password" => 'password', "password_confirmation" => 'password'}).and_return({"password" => ["wrong"]})
      put :update, user: {"email" => 'dave@dive.com', "reset_password_token" => '1234', "password" => 'password', "password_confirmation" => 'password'}
      response.should render_template(:edit)
      flash[:notice].should match(/We could not reset your password/)
    end

  end

end
