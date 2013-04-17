module GiveyRails
  class Channel
    include GiveyModel

    attr_accessor :node_type,
      :charity,
      :id,
      :name,
      :givey_tag,
      :avatar_url,
      :avatar_thumb_url,
      :description,
      :donors,
      :donor_count,
      :supporters,
      :supporter_count
    
    def name_and_tag
      "#{givey_tag} - #{name}"
    end
  end
end
