module GiveyRails
  class User
    include GiveyModel
    #validates_presence_of :email, :password

    attr_accessor :id,
      :first_name,
      :last_name,
      :email,
      :secondary_email,
      :short_name,
      :avatar_url,
      :twitter_linked,
      :twitter_nickname,
      :sms_phone_number,
      :facebook_linked,
      :ppx_status,
      :total_privacy,
      :amount_privacy,
      :giftaid,
      :givey_tag,
      :avatar_thumb_url,
      :givey_score,
      :money_total,
      :voice_total,
      :time_total,
      :stuff_total,
      :currency,
      :time_donation_allowed,
      :stuff_donation_allowed,
      :biography,
      :personal_message,
      :interests,
      :location,
      :sex,
      :occupation,
      :website_url,
      :facebook_uid,
      :facebook_token,
      :channels,
      :followees,
      :followee_count,
      :followee_ids,
      :followers,
      :follower_count,
      :liked_charity_ids,
      :selected_charity,
      :selected_channel,
      :managed_charity_ids,
      :addresses,
      :business,
      :employee_match_exists,
      :employee_target_match_exists,
      :business_id,
      :business_confirmed,
      :email_flags,
      :node_type,
      :number
    
    
    # RELATIONSHIPS

    def selected_entity
      selected_channel || selected_charity
    end

    def like_this_charity?(charity)
      liked_charity_ids.include?(charity.id)
    end

    def addresses
      if @addresses.nil? || @addresses.empty?
        [GiveyRails::Address.new(first_name: first_name, last_name: last_name, country: 'GB')]
      else
        @addresses
      end
    end

    def following?(user)
      followee_ids.include?(user.id)
    end

    def name
      first_name.blank? ? "##{givey_tag}" : first_name  
    end

    def full_name
      [first_name, last_name].compact.empty? ? short_name : [first_name, last_name].compact.join(" ")
    end

    # TODO: these '_total' methods don't work
    def money_total
      Money.new(@money_total, currency).cents / 100
    end

    def stuff_total
      Money.new(@stuff_total, currency).cents / 100
    end

    def voice_total
      Money.new(@voice_total, currency).cents / 100
    end
    # TODO END 
    def money_total_display
      Money.new(@money_total, currency).cents / 100
    end

    def stuff_total_display
      Money.new(@stuff_total, currency).cents / 100
    end

    def voice_total_display
      Money.new(@voice_total, currency).cents / 100
    end

    def display_currency
      Money.new(0, currency).currency
    end

    # default currency
    def currency
      @currency.blank? ? 'GBP' : @currency
    end

    def share_types
      sts = []
      sts << 'twitter' if twitter_linked
      sts << 'facebook' if facebook_linked
      sts
    end

    # STATES
    def paypal_done
      ppx_status == 'approved'
    end

    def giftaid_done
      giftaid
    end

    def selected_charity_done
      !selected_charity.nil?
    end

    def business_state
      if !business
        "none"
      elsif !business_confirmed
        "pending"
      elsif !employee_match_exists && !employee_target_match_exists
        "attached"
      elsif employee_match_exists && employee_target_match_exists
        "all_match"
      elsif employee_match_exists
        "employee_match"
      elsif employee_target_match_exists
        "employee_target_match"
      end
      
    end

  end
end
