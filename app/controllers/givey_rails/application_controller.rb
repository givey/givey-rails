module GiveyRails
  class ApplicationController < ActionController::Base
    include GiveyRails::ControllerHelpers
    layout 'application'
  end
end
