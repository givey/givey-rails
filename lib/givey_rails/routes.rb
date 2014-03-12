module ActionDispatch::Routing

  class Mapper

    def givey_routes

      # SESSIONS
      match 'sign_in'             => 'givey_rails/sessions#new', as: :new_session, via: :get
      match 'sign_in/facebook'    => 'givey_rails/sessions#new_facebook', as: :facebook_session, via: :get
      match 'sign_in/twitter'     => 'givey_rails/sessions#new_twitter', as: :twitter_session, via: :get
      match 'sign_in'             => 'givey_rails/sessions#create', as: :session, via: :post
      match 'callback_facebook'   => 'givey_rails/sessions#create_facebook', as: :facebook_callback, via: :get
      match 'callback_twitter'   => 'givey_rails/sessions#create_twitter', as: :twitter_callback, via: :get
      match 'sign_out'            => 'givey_rails/sessions#destroy', as: :destroy_session, via: [:delete, :get]

      # ME
      match 'sign_up'             => 'givey_rails/me#new', via: :get
      resource :me, controller: "givey_rails/me", only: [:new, :create] do
        get 'paypal_link', 'paypal_link_callback'
      end

    end

  end

end
