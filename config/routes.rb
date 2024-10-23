Rails.application.routes.draw do
  resources :profiles
  resources :exercises, only: [:index, :show, :new, :create, :edit, :update, :destroy] # For web UI (admin)

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

      resources :exercises, only: [:index, :show, :create, :update, :destroy]
      resources :profiles, only: [:show]
    end
  end

  # Set the root to a web-based profiles index
  root to: "profiles#index"
end
