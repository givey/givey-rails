module GiveyRails
  class Business
    include GiveyRails::GiveyModel

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

  end
end
