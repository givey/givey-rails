module GiveyRails

  class MeController < GiveyRails::ApplicationController

    before_filter :redirect_if_signed_in, only: [:new]

    # GET /sign_up
    def new
      @me = GiveyRails::User.new(email: params[:email])
    end

    # POST /me
    def create

      # Parse full_name into first_name and last_name
      if params[:me][:full_name]
        name_parts = params[:me][:full_name].split(' ')
        params[:me][:first_name] = name_parts[0..-2].join(' ')
        params[:me][:last_name] = name_parts[-1]
        params[:me].delete(:full_name)
      end

      # Send user data to API
      response = post_token_response("/users", {user: params[:me]})

      # Success
      if response["success"]
        if request.xhr?
          render json: { success: 1 }
        else
          flash[:notice] = 'User was successfully created.'
          set_password_token(params[:me][:email], params[:me][:password])
          redirect_to_referrer
        end

      # Something went wrong
      else
        if request.xhr?
          render json: { error: response.to_json }
        else
          flash[:notice] = "Please fix the following errors to continue."
          @me = User.new(email: params[:me][:email], givey_tag: params[:me][:givey_tag])
          response.each do |attribute, errors|
            @me.errors.add(attribute, errors[0])
          end
          if @me.errors['unique_givey_tag.name']
            @me.errors.add('givey_tag', @me.errors['unique_givey_tag.name'][0])
          end
          render action: "new"
        end
      end
    end

    # GET /me/paypal_link
    def paypal_link
      url = "#{ENV['GIVEY_API_HOST']}/#{GiveyRuby.configuration.api_version}/paypal/request_preapproval?provider_redirect_url=http://#{request.host}/me/paypal_link_callback&access_token=#{access_token.token}"
      redirect_to url
    end

    # GET /me/paypal_link_callback
    def paypal_link_callback
      flash[:notice] = 'PayPal account linked'
      redirect_to_referrer
    end

  end

end
