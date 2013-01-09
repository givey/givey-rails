GiveyRails::Engine.routes.draw do

  match 'sign_in'             => 'sessions#new', as: :new_session, via: :get
=begin
  match 'sign_in/facebook'    => 'sessions#new_facebook', as: :facebook_session, via: :get
  match 'sign_in'             => 'sessions#create', as: :session, via: :post
  match 'callback_facebook'   => 'sessions#create_facebook', as: :facebook_callback, via: :get
  match 'sign_out'            => 'sessions#destroy', as: :destroy_session, via: [:delete, :get]
=end
end
