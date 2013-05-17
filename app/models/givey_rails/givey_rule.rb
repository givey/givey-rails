module GiveyRails
  class GiveyRule
    include GiveyModel

    attr_accessor :id,
      :match_amount_percent,
      :match_amount_absolute,
      :match_starts_at,
      :match_ends_at,
      :match_people,
      :action_type,
      :node_type,
      :rule_type,
      :rule_total_year,
      :rule_total_month,
      :rule_total_week,
      :rule_total_day,
      :maximum_match,
      :process_point,
      :published,
      :business_id,
      :match_on,
      :recurring,
      :application_ids
  end
end
