module GiveyRails
  module GiveyModel
    extend ActiveSupport::Concern

    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    DATETIME_FORMAT = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z\Z/ # 2012-09-19T14:54:13Z

    def initialize(attributes = {})
      attributes.each do |name, value|
        self.class.send(:attr_accessor, name.to_sym)
        value = DateTime.parse(value) if value.respond_to?(:match) && value.match(DATETIME_FORMAT).present?
        value = build_relationship(name, value) if value.kind_of? Hash
        value = build_relationships(name, value) if value.kind_of? Array
        send("#{name}=", value)
      end
    end

    def persisted?
      respond_to?(:id) && !self.id.nil?
    end

    private

    def build_relationship(name, attributes)
      return nil if attributes.empty?
      name = "user" if [:giver_target, :select_user].include?(name)
      name = "charity" if [:selected_charity].include?(name)
      name = "GiveyRails::" + name.classify
      name.constantize.new(attributes)
    end

    def build_relationships(name, value)
      return nil if value.empty?
      klass_name = [:supporters, :donors, :followees, :followers].include?(name.to_sym) ? "users" : name
      klass_name = "GiveyRails::" + klass_name.singularize.classify
      value.map {|attrs| klass_name.constantize.new(attrs[name.singularize]) }
    end
  end
end
