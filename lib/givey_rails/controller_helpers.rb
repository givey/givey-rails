
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

    def find_me
      @me = User.new(get_token_response("/me"))
    end

  end

end
