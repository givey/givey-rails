module GiveyRails
  class User
    include GiveyModel
    #validates_presence_of :email, :password

    attr_accessor :selected_charity_id
    # RELATIONSHIPS

    def selected_entity
      selected_channel || selected_charity
    end

    def like_this_charity?(charity)
      liked_charity_ids.include?(charity.id)
    end

    def addresses
      @addresses.empty? ? [GiveyRails::Address.new(first_name: first_name, last_name: last_name, country: 'GB')] : @addresses
    end

    def following?(user)
      followee_ids.include?(user.id)
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
    #TODOEND 
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

    def paypal_done
      ppx_status == 'approved'
    end

    def giftaid_done
      giftaid
    end

    def selected_charity_done
      !selected_charity.nil?
    end
  end
end
