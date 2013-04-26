module GiveyRails
  class Story
    include GiveyModel

    attr_accessor :id,
      :created_at,
      :user_id,
      :user_name,
      :user_thumb_url,
      :content_title,
      :content_text,
      :activity_asset,
      :activity_asset_url,
      :activity_asset_square_url,
      :activity_asset_thumb_url,
      :node_type,
      :donation,
      :donation_id

  end
end
