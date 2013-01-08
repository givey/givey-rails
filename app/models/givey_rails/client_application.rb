module GiveyRails
  class ClientApplication
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :client_id,
      :name,
      :support_url

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      !(self.id.nil?)
    end
  end
end
