module GiveyRails
  class ApplicationController < ActionController::Base
    include GiveyRails::ControllerHelpers
    layout 'application'

    private

    def redirect_if_signed_in
      redirect_to root_path if signed_in?
    end

    def find_and_set_referrer
      referrer = params[:client_redirect_url] || request.referer
      set_referrer(referrer) unless session[:referrer]
    end

  end
end
