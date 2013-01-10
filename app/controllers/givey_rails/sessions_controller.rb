module GiveyRails

  class SessionsController < GiveyRails::ApplicationController

    respond_to :html

    # GET /sign_in
    def new
      @me = User.new
    end

    # POST /sign_in
    def create
      if set_password_token(params[:me][:email], params[:me][:password])
        #render json: ["1"].to_json and return if modal?
      else
        #render json: ["0"].to_json and return if modal?
      end
      redirect_to_referrer
    end

=begin
    # GET /sign_in/facebook
    def new_facebook
      url = "#{ENV['GIVEY_API_HOST']}/#{GiveyRailsSdk.configuration.api_version}/authorize/facebook?provider_redirect_url=http://#{request.host}/callback_facebook&access_token=#{access_token.token}"
      redirect_to url
    end

    # GET /callback/facebook
    def create_facebook
      unless params[:access_token].blank?
        # TODO: login fails
        login_token_user(params[:access_token])
        redirect_to_or_back
      else
        flash[:notice]  = "your login was unsuccessful"
        render action: :new
      end

    end
=end

    # DELETE / GET /sign_out
    def destroy
      token_sign_out
      redirect_to root_path
    end

  end

end
