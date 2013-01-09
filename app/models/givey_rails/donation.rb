module GiveyRails
  class Donation
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :id,
      :charity_id,
      :charity_name,
      :channel_id,
      :amount,
      :currency,
      :any_stories,
      :node_type,
      :created_at,
      :stream_thumb_url,
      :raised,
      :user_id,
      :user_name,
      :user_thumb_url,
      :giver_target_id,
      :giver_target_name,
      :giver_target_thumb_url,
      :donation_type,
      :time_unit,
      :approval_code,
      :approve,
      :donated_at,
      :stuff_name,
      :channel_name,
      :channel_givey_tag,
      :channel_id

    validates_presence_of :amount


    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      !(self.id.nil?)
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def donated_at
      DateTime.parse(@donated_at)
    end

    # RELATIONSHIPS
    def charity
      @charity
    end

    def charity=(charity_attributes)
      @charity = charity_attributes ? Charity.new(charity_attributes) : nil
    end

    def channel
      @channel
    end

    def channel=(channel_attributes)
      @channel = channel_attributes ? Channel.new(channel_attributes) : nil
    end

    def giver_target
      @giver_target
    end

    def giver_target=(giver_target_attributes)
      @giver_target = giver_target_attributes ? User.new(giver_target_attributes) : nil
    end

    def display_amount
      Money.new(amount, currency).cents / 100
    end

    def display_currency
      Money.new(amount, currency).currency
    end
  end
end
