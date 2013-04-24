Rails.application.routes.draw do

  givey_routes

  resource :me, controller: :me, only: [:show]

  match "protected" => 'home#protected', as: :protected
  match "redirected" => 'home#redirected', as: :redirected
  match "invalid_token" => 'home#invalid_token', as: :invalid_token
  root :to => 'home#index'

end
