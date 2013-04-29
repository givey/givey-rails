ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular(/ess$/i, 'ess')
  inflect.irregular 'business', 'businesses'
end
