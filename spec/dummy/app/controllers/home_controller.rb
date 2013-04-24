class HomeController < ApplicationController

  before_filter :check_user_signed_in, only: [:protected]

  def index
    render text: 'HOME'
  end

  def redirected
    redirect_to_referrer
  end

  def protected
    render text: 'PROTECTED'
  end

  def invalid_token
    current_givey_user
    render text: 'invalid'
  end

end
