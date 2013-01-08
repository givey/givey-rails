class ApplicationController < ActionController::Base
  include GiveyRails::ControllerHelpers
  protect_from_forgery
end
