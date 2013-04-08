module GiveyRails
  class Donation
    include GiveyRails::GiveyModel

    validates_presence_of :amount

    def donated_entity
      channel || charity
    end

    def display_amount
      Money.new(amount, currency).cents / 100
    end

    def display_currency
      Money.new(amount, currency).currency
    end

    def donation_string_html
      if donation_string_textile =~ /time-\d+-time/
        str_amt       = donation_string_textile.match(/time-(\d+)-time/).captures[0].to_i
        time_str      = time_donation_format(str_amt)
        replaced_str  = donation_string_textile.gsub(/time-\d+-time/, time_str)
      else
        str_cur, str_amt  = donation_string_textile.match(/amt-([a-z]{3}|[A-Z]{3})(\d+)-amt/).captures
        money_object      = Money.new(str_amt, str_cur)
        replaced_str      = donation_string_textile.gsub(/amt-([a-z]{3}|[A-Z]{3})/, money_object.currency.symbol).gsub(/\d+-amt/, (money_object.cents / 100).to_s)
      end
      RedCloth.new(replaced_str, [:lite_mode]).to_html
    end

    def donation_images_html
      full_string = donation_images_textile.map{|s| "div(avatar). " + s}.join("\n\n")
      RedCloth.new(full_string).to_html  
    end

    def time_donation_format(seconds)
      mm, ss = seconds.divmod(60)
      hh, mm = mm.divmod(60)
      "%d hours and %d minutes" % [hh, mm]
    end

  end
end
