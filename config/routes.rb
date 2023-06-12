Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_applications, :tokens, :token_info
  end

  devise_for :users, skip: [:registrations, :confirmations, :sessions, :passwords], skip_helpers: true

  namespace :api do
    namespace :v1 do
      use_doorkeeper do
        controllers tokens: 'tokens'
        skip_controllers :authorizations, :applications, :authorized_applications, :token_info, :tokens
      end

      resources :keywords, only: :index
      resources :private_items, only: :index
      post '/signup', to: 'registrations#create'
    end
  end

  resources :public_items, only: :index
  resources :private_items, only: :index
end
