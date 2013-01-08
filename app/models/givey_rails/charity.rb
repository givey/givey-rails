module GiveyRails
  class Charity
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :id,
      :givey_tag,
      :name,
      :node_type,
      :avatar_url,
      :avatar_thumb_url,
      :info_description,
      :user_donations_total,
      :donor_count,
      :supporter_count,
      :time_donation_accepted,
      :stuff_donation_accepted,
      :has_admin_user,
      :has_channels

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      !(self.id.nil?)
    end

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def select_user
      @select_user
    end

    def select_user=(user_name)
      @select_user  = user_name
    end

    def user_donations_total
      Money.new(@user_donations_total).cents / 100
    end

    def donors
      @donors
    end

    def donors=(users_attributes)
      @donors = users_attributes.map{|user_attributes| User.new(user_attributes["donor"]) }
    end

    def supporters
      @supporters
    end

    def supporters=(users_attributes)
      @supporters = users_attributes.map{|user_attributes| User.new(user_attributes["supporter"]) }
    end

    def channels
      @channels    
    end

    def channels=(channels_attributes)
      @channels = channels_attributes.map{|user_attributes| Channel.new(user_attributes["channel"]) }
    end
  end
end
