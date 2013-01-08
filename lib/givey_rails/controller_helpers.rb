module GiveyRails

  module ControllerHelpers

    extend ActiveSupport::Concern

    included do
      helper_method :signed_in? #, :other_method
    end

    module ClassMethods

    end

    def signed_in?

    end


  end

end
