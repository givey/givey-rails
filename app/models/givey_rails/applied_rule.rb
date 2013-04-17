module GiveyRails
  class AppliedRule
    include GiveyModel

    attr_accessor :business_id,
      :business_name,
      :business_thumb_url,
      :amount

    def display_amount
      Money.new(amount, 'gbp').cents / 100
    end

  end
end
