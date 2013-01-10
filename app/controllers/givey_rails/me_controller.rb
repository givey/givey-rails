module GiveyRails

  class MeController < GiveyRails::ApplicationController

    # GET /sign_up
    def new
      @me = GiveyRails::User.new
    end

    # POST /me
    def create
      response = post_token_response("/users", {user: params[:me]})
      if response["success"]
        flash[:notice] = 'User was successfully created.'
        set_password_token(params[:me][:email], params[:me][:password])
        redirect_to_referrer
      else
        @me = User.new(email: params[:me][:email], givey_tag: params[:me][:givey_tag])
        response.each do |attribute, errors|
          @me.errors.add(attribute, errors[0])
        end
        render action: "new"
      end
    end
=begin
    # GET /me/paypal_link
    def paypal_link
      url = "#{ENV['GIVEY_API_HOST']}/#{GiveyRailsSdk.configuration.api_version}/paypal/request_preapproval?provider_redirect_url=http://#{request.host}/me/paypal_link_callback&access_token=#{access_token.token}"
      redirect_to url
    end

    # GET /me/paypal_link_callback
    def paypal_link_callback
      flash[:notice] = 'PayPal account linked'
      redirect_to_or_back
    end
=end
  end

end
