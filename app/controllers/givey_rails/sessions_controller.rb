module GiveyRails

  class SessionsController < GiveyRails::ApplicationController

    respond_to :html

    before_filter :find_and_set_referrer, only: [:new_facebook, :new_twitter, :new]
    before_filter :redirect_if_signed_in, only: [:new]

    # GET /sign_in
    def new
    end

    # POST /sign_in
    def create
      if set_password_token(params[:me][:email], params[:me][:password])
        unless request.xhr?
          redirect_to_referrer
          flash[:notice] = "Signed in successfully"
        else
          render json: { redirect: session[:referer] || root_path }
        end
      else
        unless request.xhr?
          flash[:error] = "Sorry, email and password did not match."
          redirect_to new_session_path
        else
          render json: { error: 'Sorry, email and password did not match.' }
        end
      end
    end

    # GET /sign_in/facebook
    def new_facebook
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
      [ENV['GIVEY_API_HOST'], GiveyRuby.configuration.api_version, "authorize", provider].join("/") + "?provider_redirect_url=#{return_url(provider)}&business_id=#{session[:inbound_business]}"
    end

    def return_url(provider)
      "http://#{request.host}/callback_#{provider}&access_token=#{access_token.token}"
    end

  end

end

