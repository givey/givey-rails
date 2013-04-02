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

    def donation_string_html
      str_cur, str_amt  = donation_string_textile.match(/amt-([a-z]{3}|[A-Z]{3})(\d+)-amt/).captures
      money_object      = Money.new(str_amt, str_cur)

      replaced_str      = donation_string_textile.gsub(/amt-([a-z]{3}|[A-Z]{3})/, money_object.currency.symbol).gsub(/\d+-amt/, (money_object.cents / 100).to_s)
      RedCloth.new(replaced_str, [:lite_mode]).to_html
    end

  end
end
