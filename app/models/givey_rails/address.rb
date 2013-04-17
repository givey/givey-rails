module GiveyRails
  class Address
    include GiveyRails::GiveyModel
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
      :node_type
  end
end
