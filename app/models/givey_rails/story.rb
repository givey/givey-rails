module GiveyRails
  class Story
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :id,
      :donation_id,
      :charity_id,
      :charity_name,
      :content_title,
      :content_text,
      :activity_asset,
      :activity_asset_url,
      :activity_asset_square_url,
      :activity_asset_thumb_url,
      :stream_thumb_url,:user_id,
      :user_name,
      :user_thumb_url,
      :node_type,
      :created_at

    #validates_presence_of :amount, :donation_id

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

    # RELATIONSHIPS
    def donation
      @donation
    end

    def donation=(donation_attributes)
      @donation = donation_attributes ? Donation.new(donation_attributes) : nil
    end
  end
end
