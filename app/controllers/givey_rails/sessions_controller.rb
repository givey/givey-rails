module GiveyRails

  class SessionsController < GiveyRails::ApplicationController

    respond_to :html

    # GET /sign_in
    def new
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

    # GET /sign_in/facebook
    def new_facebook
      set_referrer(request.referer)
      redirect_to authentication_url("facebook")
    end

    # GET /callback/facebook
    def create_facebook
      if params[:access_token]
        # TODO: login fails
        login_token_user(params[:access_token])
        redirect_to_referrer
      else
        flash[:notice]  = "your login was unsuccessful"
        render action: :new
      end

    end

    # GET /sign_in/twitter
    def new_twitter
      set_referrer(request.referer)
      redirect_to authentication_url ("twitter")
    end

    # GET /callbacks/twitter
    def create_twitter
      if params[:access_token]
        login_token_user(params[:access_token])
        redirect_to_referrer
      else
        flash[:notice] = "Your login was unsuccessful"
        render action: :new
      end
    end

    # DELETE / GET /sign_out
    def destroy
      token_sign_out
      redirect_to root_path
    end

    private

    def authentication_url(provider)
      [ENV['GIVEY_API_HOST'], GiveyRuby.configuration.api_version, "authorize", provider].join("/") + "?provider_redirect_url=#{return_url(provider)}"
    end

    def return_url(provider)
      "http://#{request.host}/callback_#{provider}&access_token=#{access_token.token}"
    end

  end

end

