module GiveyRails
  class RecurringDonation
    include GiveyRails::GiveyModel

    attr_accessor :id,
      :node_type,
      :user,
      :charity,
      :channel,
      :giver_target,
      :starts_at,
      :ends_at,
      :next_donation,
      :alive,
      :published,
      :amount,
      :currency,
      :donations


    def donated_entity
      channel || charity
    end

    def display_amount
      Money.new(amount, currency).cents / 100
    end

    def display_currency
      Money.new(amount, currency).currency
    end

  end
end
