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
      :video_link,
      :description,
      :donors,
      :donor_count,
      :supporters,
      :supporter_count,
      :just_giving_link,
      :fundraising_target,
      :charity_donations_total,
      :business_invitation_email
    
    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def charity_donations_total_display 
      Money.new(@charity_donations_total).cents / 100
    end

    def percentage_target
      if fundraising_target > 0
        ((charity_donations_total_display.to_f || 0) / fundraising_target.to_f) * 100
      else
        0
      end
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
