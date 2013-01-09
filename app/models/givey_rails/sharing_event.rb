module GiveyRails
  class SharingEvent
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming
    include GiveyRuby::Model

    attr_accessor :id,
      :shared_activity_id,
      :shared_activity_user_id,
      :node_type,
      :shared_node_type,
      :created_at,
      :content_text,
      :stream_thumb_url,
      :share_types,
      :user_id,
      :user_name,
      :user_thumb_url

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def givey_token
      nil
    end

    def persisted?
      !(self.id.nil?)
    end

    def shared_activity
      Story.new(get_token_response("/users/#{shared_activity_user_id}/stories/#{shared_activity_id}"))
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def shared_node_klass
      shared_node_type.camelize.constantize
    end
  end
end
