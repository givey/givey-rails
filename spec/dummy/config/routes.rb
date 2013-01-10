Rails.application.routes.draw do

  givey_routes

  resource :me, controller: :me, only: [:show]

  match "protected" => 'home#protected', as: :protected
  match "redirected" => 'home#redirected', as: :redirected
  root :to => 'home#index'

end
