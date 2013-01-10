module GiveyRails
  class Charity
    include GiveyRails::GiveyModel

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    def user_donations_total
      Money.new(@user_donations_total).cents / 100
    end
  end
end
