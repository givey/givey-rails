module GiveyRails
  class Charity
    include GiveyRails::GiveyModel

    attr_accessor :id,
      :name,
      :givey_tag,
      :info_description,
      :description,
      :avatar_url,
      :avatar_thumb_url,
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
