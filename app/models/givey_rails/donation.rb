module GiveyRails
  class Donation
    include GiveyRails::GiveyModel

    attr_accessor :node_type,
      :user,
      :donation_type,
      :donation_string_textile,
      :donation_string_share,
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
      :giver_target_id,
      :giver_target_name,
      :giver_target_givey_tag,
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
      display_amount.to_f * 1.25
    end

    def giftaid_display_amount
      sprintf("%0.2f", giftaid_amount)
    end

    def display_combined_amount
      Money.new(combined_amount, currency).cents / 100
    end

    # default currency
    def currency
      @currency.blank? ? 'GBP' : @currency
    end

    def display_currency
      Money.new(amount, currency).currency
    end

    def donation_string_html
      RedCloth.new(donation_string_textile, [:lite_mode]).to_html
    end

    def donation_string_plain
      replaced_str.gsub(/\[[^\]]+:http:\/\/givey.com\/(\w+)\]/){|m| "##{$1}" }
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
