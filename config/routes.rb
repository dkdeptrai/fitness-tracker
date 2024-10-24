Rails.application.routes.draw do
  # Web-based routes (return HTML)
  resources :profiles
  resources :exercises, only: [:index, :show, :new, :create, :edit, :update, :destroy] # For web UI (admin)

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get "up" => "rails/health#show", as: :rails_health_check

  # API routes (return JSON)
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

      resources :exercises, only: [:index, :show, :create, :update, :destroy] do
        get :search, on: :collection
      end
      resources :profiles, only: [:show]
    end
  end

  # Set the root to a web-based profiles index
  root to: "profiles#index"
end
