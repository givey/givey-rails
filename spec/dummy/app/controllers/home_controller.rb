class HomeController < ApplicationController

  before_filter :check_user_signed_in, only: [:protected]

  def index
    render text: 'HOME'
  end

  def protected
    render text: 'PROTECTED'
  end

end
