module GiveyRails

  class PasswordsController < GiveyRails::ApplicationController

    def new
      # clear the access token
      redirect_to dashboard_path if signed_in?
      session[:access_token] = nil
      @user                  = GiveyRails::User.new(email: params[:email])
    end

    def create
      user_params = params[:user].merge(password_reset_url: "#{request.protocol}#{request.host}/password/edit")
      response  = post_token_response("/users/password", {user: user_params})
      if response.has_key?("id")
        flash[:notice] = "Your password reset instructions have been sent"
      elsif response["message"] == "not found"
        flash[:notice] = "We could not find a user with that email address"
      else
        raise Exceptions::GiveyApiError, response["error"]
      end
      redirect_to new_password_path(email: params[:user][:email])
    end

    def edit
      @user = GiveyRails::User.new(reset_password_token: params[:reset_password_token])
    end

    def update
      response  = put_token_response("/users/password", {user: params[:user]})
      if response.has_key?("token")
        login_token_user(response["token"])
        flash[:notice] = "Your password has been reset"
        redirect_to root_path
      else
        @user = User.new(reset_password_token: params[:user][:reset_password_token])
        response.each do |attribute, errors|
          @user.errors.add(attribute, errors[0])
        end
        notice_text = "We could not reset your password:<br/>"
        notice_text << @user.errors.full_messages.join("<br/>")
        notice_text << "<br/><br/><a href='#{new_password_path}'>Reset your password again</a>"
        flash[:notice] = notice_text.html_safe
        render action: :edit
      end

    end

  end

end
