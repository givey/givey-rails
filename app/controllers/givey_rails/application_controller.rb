module GiveyRails
  class ApplicationController < ActionController::Base
    include GiveyRails::ControllerHelpers
    layout 'application'

    helper_method :meta_data

    private

    def meta_data
      {}
    end

    def redirect_if_signed_in
      referer = params[:client_redirect_url] || root_path
      redirect_to referer if signed_in?
    end

    def find_and_set_referrer
      referrer = params[:client_redirect_url] || request.referer
      set_referrer(referrer) unless session[:referrer]
    end

  end
end
