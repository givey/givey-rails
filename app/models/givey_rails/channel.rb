module GiveyRails
  class Channel
    include GiveyModel

    attr_accessor :node_type,
      :charity,
      :charity_id,
      :user,
      :user_id,
      :id,
      :name,
      :givey_tag,
      :avatar_url,
      :avatar_thumb_url,
      :hero_image_url,
      :hero_image_small_url,
      :hero_image_email_url,
      :description,
      :donors,
      :donor_count,
      :supporters,
      :supporter_count,
      :just_giving_link,
      :fundraising_target,
      :charity_donations_total
    
    def name_and_tag
      "#{givey_tag} - #{name}"
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
