Rails.application.routes.draw do

  mount GiveyRails::Engine => "/givey_rails", :as =>"givey_rails"

  match "protected" => 'home#protected', as: :protected
  root :to => 'home#index'

end
