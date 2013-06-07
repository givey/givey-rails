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
      :supporter_count,
      :charity_donations_total
    
    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def charity_donations_total_display 
      Money.new(@charity_donations_total).cents / 100
    end

    # default currency
    def currency
      @currency.blank? ? 'GBP' : @currency
    end

    def display_currency
      Money.new(0, currency).currency
    end

  end
end
