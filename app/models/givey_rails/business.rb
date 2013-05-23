module GiveyRails
  class Business
    include GiveyRails::GiveyModel

    attr_accessor :id,
      :name,
      :givey_tag,
      :about,
      :avatar,
      :avatar_url,
      :avatar_thumb_url,
      :email_domain,
      :ppx_status,
      :match_total_cache,
      :match_count_cache,
      :public_profile,
      :profile_message,
      :twitter_handle,
      :facebook_page,
      :node_type

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def paypal?
      ppx_status == 'approved'
    end

  end
end
