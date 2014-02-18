require 'spec_helper'

describe GiveyRails::SessionsController do

  describe "GET /sign_in" do

    context "when signed in" do
      it "redirects" do
        controller.stub(:signed_in?).and_return(true)
        get :new
        response.should redirect_to(root_path)
      end
    end

    context "with client_redirect_url parameter" do
      let(:connect_path) { 'https://connect.givey.com' }
      let(:client_redirect_url) { "/an_url" }
      before do
        controller.stub(:connect_path).and_return(connect_path)
      end
      it "updates the session referer" do
        get :new, client_redirect_url: client_redirect_url
        expected_url = "http://#{request.host}#{client_redirect_url}"
        expect(response).to redirect_to("#{connect_path}?redirect_url=#{URI.escape(expected_url)}")
      end
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

  describe "GET /sign_in/facebook" do

    it "should do the correct redirect" do
      controller.stub_chain(:access_token, :token).and_return('123sdf654')
      controller.should_receive(:find_and_set_referrer)
      get :new_facebook
      response.status.should == 302
      response.header["Location"].should match(/authorize\/facebook\?provider_redirect_url/)
    end

    it "should store the provided redirect" do
      controller.stub_chain(:access_token, :token).and_return('123sdf654')
      get :new_facebook, client_redirect_url: "/an_url"
      session[:referrer].should == "/an_url"
    end

  end

  describe "GET /callback/facebook" do

    it "should log me in" do
      controller.stub(:params).and_return(access_token: '123sdf654')
      controller.should_receive(:login_token_user).with('123sdf654')
      get :create_facebook
      response.should redirect_to(root_path)
    end

    it "should not log me in" do
      controller.stub(:params).and_return(access_token: nil)
      controller.should_receive(:login_token_user).never
      get :create_facebook
      response.should render_template(:new)
    end

  end

  describe "GET /sign_in/twitter" do
    it "redirects correctly" do
      controller.stub_chain(:access_token, :token).and_return('123sdf654')
      get :new_twitter
      response.status.should == 302
      response.header["Location"].should match(/authorize\/twitter\?provider_redirect_url/)
    end

    it "should store the provided redirect" do
      controller.stub_chain(:access_token, :token).and_return('123sdf654')
      get :new_twitter, client_redirect_url: "/an_url"
      session[:referrer].should == "/an_url"
    end
  end

  describe "GET /callback/twitter" do
    it "logs me in" do
      controller.stub(:params).and_return(access_token: '123sdf654')
      controller.should_receive(:login_token_user).with('123sdf654')
      get :create_twitter
      response.should redirect_to(root_path)
    end

    context "without an access_token" do
      it "does not log me in" do
        controller.stub(:params).and_return(access_token: nil)
        controller.should_receive(:login_token_user).never
        get :create_twitter
        response.should render_template(:new)
      end
    end
  end

  describe "GET / DELETE /sign_out" do

    context "givey connect host" do

      before do
        ENV['GIVEY_CONNECT_HOST'] = "https://connect.givey.com"
      end
      after do
        ENV.delete('GIVEY_CONNECT_HOST')
      end

      it "should successfully logout a user" do
        session[:user_id]       = '1234'
        session[:access_token]  = '0987'
        controller.access_token.stub(:get).with("/v2/oauth/revoke")
        get :destroy
        response.should redirect_to("#{ENV['GIVEY_CONNECT_HOST']}/sign_out")
        session[:user_id].should be_nil
      end

    end

    context "no givey connect host" do

      it "should successfully logout a user" do
        session[:user_id]       = '1234'
        session[:access_token]  = '0987'
        controller.access_token.stub(:get).with("/v2/oauth/revoke")
        get :destroy
        response.should redirect_to(root_path)
        session[:user_id].should be_nil
      end

    end

  end



end
