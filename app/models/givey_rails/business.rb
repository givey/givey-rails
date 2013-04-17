module GiveyRails
  class Business
    include GiveyRails::GiveyModel

    attr_accessor :id,
      :name,
      :givey_tag,
      :about,
      :avatar_url,
      :avatar_thumb_url,
      :email_domain,
      :ppx_status

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

  end
end
