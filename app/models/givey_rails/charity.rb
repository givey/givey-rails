module GiveyRails
  class Charity
    include GiveyRails::GiveyModel

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def user_donations_total
      Money.new(@user_donations_total).cents / 100
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
