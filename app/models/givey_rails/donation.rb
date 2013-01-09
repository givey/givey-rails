module GiveyRails
  class Donation
    include GiveyRails::GiveyModel

    validates_presence_of :amount

    def display_amount
      Money.new(amount, currency).cents / 100
    end

    def display_currency
      Money.new(amount, currency).currency
    end
  end
end
