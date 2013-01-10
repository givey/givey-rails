class MeController < ApplicationController

  before_filter :check_its_me

  def show
    render text: 'ME SHOW'
  end

end
