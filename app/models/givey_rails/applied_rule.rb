module GiveyRails
  class AppliedRule
    include GiveyModel

    def display_amount
      Money.new(amount, 'gbp').cents / 100
    end

  end
end
