module GiveyRails
  class FollowingEvent
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :id,
      :followed_user_id,
      :followed_user_name,
      :user_id,
      :user_name,
      :user_thumb_url,
      :node_type,
      :created_at,
      :stream_thumb_url

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
  end
end
