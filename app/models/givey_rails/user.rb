module GiveyRails
  class User
    include GiveyModel
    #validates_presence_of :email, :password

    # RELATIONSHIPS
    def selected_charity
      @selected_charity
    end

    def selected_charity=(charity_attributes)
      @selected_charity = charity_attributes ? Charity.new(charity_attributes) : nil
    end

    def like_this_charity?(charity)
      liked_charity_ids.include?(charity.id)
    end

    def addresses
      @addresses.empty? ? [Address.new(first_name: first_name, last_name: last_name, country: 'GB')] : @addresses
    end

    def addresses=(addresses_attributes)
      @addresses = addresses_attributes.map{|address_attributes| Address.new(address_attributes["address"]) }
    end

    def followees
      @followees
    end

    def followees=(users_attributes)
      @followees = users_attributes.map{|user_attributes| User.new(user_attributes["followee"]) }
    end

    def following?(user)
      followee_ids.include?(user.id)
    end

    def followers
      @followers
    end

    def followers=(users_attributes)
      @followers = users_attributes.map{|user_attributes| User.new(user_attributes["follower"]) }
    end

    def full_name
      [first_name, last_name].compact.empty? ? short_name : [first_name, last_name].compact.join(" ")
    end

    def money_total
      Money.new(@money_total, currency).cents / 100
    end

    def stuff_total
      Money.new(@stuff_total, currency).cents / 100
    end

    def voice_total
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
