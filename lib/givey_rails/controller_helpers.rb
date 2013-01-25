
module GiveyRails

  module ControllerHelpers

    extend ActiveSupport::Concern
    include GiveyRuby::Controller

    included do
      helper_method :signed_in?, :current_givey_user, :is_it_me?
    end

    module ClassMethods

    end

    def signed_in?
      !session[:user_id].blank?
    end

    def check_user_signed_in
      redirect_to new_session_path and return unless signed_in?
    end

    def current_givey_user
      @current_givey_user ||= GiveyRails::User.new(get_token_response("/me"))
    end

    # is this a current_user page?
    # also a helper_method
    def is_it_me?
      @its_me ||= request.fullpath =~ /\/me(\/|\Z)/
    end

    # use this as a before_filter / before_action
    def check_its_me
      check_user_signed_in if is_it_me?
    end

    def givey_user
      @givey_user ||= begin
        if is_it_me?
          current_givey_user
        elsif params[:user_id]
          User.new(get_token_response("/users/#{params[:user_id]}"))
        else
          nil
        end
      end
    end

    def set_referrer(redirect_url = request.referer)
      session[:referrer]  = redirect_url
    end

    def redirect_to_referrer
      if session[:referrer]
        referrer = session[:referrer]
        session[:referrer] = nil
        redirect_to referrer and return
      else
        redirect_to root_path and return
      end
    end

  end

end
