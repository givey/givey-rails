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
      :banner_url,
      :charities,
      :email_domain,
      :ppx_status,
      :match_total_cache,
      :match_count_cache,
      :public_profile,
      :moment_credits,
      :paid_moments_count,
      :unpaid_moments_count,
      :profile_message,
      :twitter_handle,
      :facebook_page,
      :gocardless_preauthorization_id,
      :gocardless_preauthorization_status,
      :node_type

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def paypal?
      ppx_status == 'approved'
    end

    def twitter_greeting
      twitter_handle ? "@#{twitter_handle}" : name
    end

  end
end
