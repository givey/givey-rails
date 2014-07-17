module GiveyRails
  class Charity
    include GiveyRails::GiveyModel

    CATEGORIES  = [
      #"Culture, Sport, and Recreation",
      "Education and Science",
      "Health and Medicine",
      "Social Services and Relief",
      "Environment and Protection of Animals",
      "Housing and Community Affairs",
      "Civil Rights and Citizenship",
      "Philanthropic Intermediation",
      "International",
      "Business and Professional",
      "Religious"
    ]


    attr_accessor :id,
      :name,
      :givey_tag,
      :missionfish_id,
      :info_description,
      :description,
      :handle_twitter,
      :handle_facebook,
      :url_website,
      :avatar_url,
      :avatar_thumb_url,
      :hero_image_url,
      :hero_image_small_url,
      :hero_image_email_url,
      :video_link,
      :contact_email,
      :contact_phone,
      :contact_name,
      :charity_donations_total,
      :time_donation_accepted,
      :stuff_donation_accepted,
      :has_channels,
      :channels,
      :donors,
      :donor_count,
      :supporters,
      :supporter_count,
      :has_admin_user,
      :node_type

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def twitter_greeting
      handle_twitter ? "@#{handle_twitter}" : name
    end

    def user_donations_total
      Money.new(@user_donations_total).cents / 100
    end

    def charity_donations_total_display
      Money.new(@charity_donations_total).cents / 100
    end

    # default currency
    def currency
      @currency.blank? ? 'GBP' : @currency
    end

    def display_currency
      Money.new(0, currency).currency
    end

  end
end
