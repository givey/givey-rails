module GiveyRails
  class Channel
    include GiveyModel

    def name_and_tag
      "#{givey_tag} - #{name}"
    end
  end
end
