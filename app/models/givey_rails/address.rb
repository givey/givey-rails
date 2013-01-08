module GiveyRails
  class Address
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :id,
      :address_name,
      :first_name,
      :last_name,
      :address1,
      :address2,
      :address3,
      :city,
      :county,
      :country,
      :post_code,
      :phone_number,
      :node_type,
      :created_at

    #validates_presence_of :amount, :donation_id


    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      !(self.id.nil?)
    end

    def created_at
      DateTime.parse(@created_at)
    end
  end
end
