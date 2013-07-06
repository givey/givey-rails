module GiveyRails
  class Donation
    include GiveyRails::GiveyModel

    attr_accessor :node_type,
      :user,
      :donation_type,
      :donation_string_textile,
      :donation_images_textile,
      :charity,
      :channel,
      :giver_target,
      :story,
      :id,
      :activity_id,
      :created_at,
      :donated_at,
      :user_id,
      :user_name,
      :user_thumb_url,
      :amount,
      :currency,
      :charity_name,
      :charity_id,
      :any_stories,
      :channel_id,
      :channel_name,
      :channel_givey_tag,
      :combined_amount,
      :applied_rules,
      :stream_thumb_url,
      :pp_invoice_id,
      :canonical_url

    validates_presence_of :amount

    def donated_entity
      channel || charity
    end

    def display_donated_entity
      if channel && channel.user
        channel.charity
      elsif channel
        channel
      else
        charity
      end
    end

    def display_amount
      Money.new(amount, currency).cents / 100
    end

    def giftaid_amount
      display_amount.to_f * 1.2
    end

    def giftaid_display_amount
      sprintf("%0.2f", giftaid_amount)
    end

    def display_combined_amount
      Money.new(combined_amount, currency).cents / 100
    end

    def display_currency
      Money.new(amount, currency).currency
    end

    def donation_string_html
      RedCloth.new(replaced_str, [:lite_mode]).to_html
    end

    def donation_string_plain
      replaced_str.gsub(/\[[^\]]+:http:\/\/givey.com\/(\w+)\]/){|m| "##{$1}" }
    end

    def replaced_str
      if donation_string_textile =~ /time-\d+-time/
        str_amt       = donation_string_textile.match(/time-(\d+)-time/).captures[0].to_i
        time_str      = time_donation_format(str_amt)
        donation_string_textile.gsub(/time-\d+-time/, time_str)
      elsif donation_string_textile =~ /amt-.+-amt/
        str_cur, str_amt  = donation_string_textile.match(/amt-([a-z]{3}|[A-Z]{3})(\d+)-amt/).captures
        money_object      = Money.new(str_amt, str_cur)
        donation_string_textile.gsub(/amt-([a-z]{3}|[A-Z]{3})/, money_object.currency.symbol).gsub(/\d+-amt/, (money_object.cents / 100).to_s)
      else
        donation_string_textile
      end
    end

    def donation_images_html
      full_string = donation_images_textile.map do |s|
        css_classes = s.match(/\((.+)\)/)[1]
        "div(#{css_classes}). " + s
      end.join("\n\n")
      RedCloth.new(full_string).to_html  
    end

    def time_donation_format(seconds)
      mm, ss = seconds.divmod(60)
      hh, mm = mm.divmod(60)
      "%d hours and %d minutes" % [hh, mm]
    end

  end
end
