
module GiveyRails

  module ControllerHelpers

    extend ActiveSupport::Concern
    include GiveyRuby::Controller

    included do
      helper_method :signed_in? #, :other_method
    end

    module ClassMethods

    end

    def signed_in?
      !session[:user_id].blank?
    end

    def check_user_signed_in
      redirect_to givey_rails.new_session_path unless signed_in?
    end

    def find_me
      @me = User.new(get_token_response("/me"))
    end

  end

end
