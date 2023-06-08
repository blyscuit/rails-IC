Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_applications, :tokens, :token_info
  end

  devise_for :users, skip: [:registrations, :confirmations, :sessions, :passwords], skip_helpers: true
  
  namespace :api do
    namespace :v1 do
      resources :keywords, only: :index
      resources :private_items, only: :index
    end
  end

  resources :public_items, only: :index
  resources :private_items, only: :index
end
