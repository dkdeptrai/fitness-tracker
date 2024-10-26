Rails.application.routes.draw do
  # Web-based routes (return HTML)
  resources :profiles
  resources :exercises

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  # API routes (return JSON)
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

      resources :exercises, only: [:index, :show, :create, :update, :destroy] do
        get :search, on: :collection
      end
      resources :workouts
      resources :workout_sets
      resources :profiles
    end
  end

  # Set the root to a web-based profiles index
  root to: "profiles#index"
end
