module GiveyRails
  class Channel
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :id,
      :givey_tag,
      :name,
      :node_type,
      :description

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      !(self.id.nil?)
    end

    def name_and_tag
      "#{givey_tag} - #{name}"
    end

    # RELATIONSHIPS
    def charity
      @charity
    end

    def charity=(charity_attributes)
      @charity = charity_attributes ? Charity.new(charity_attributes) : nil
    end
  end
end
