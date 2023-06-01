Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :authorized_applications, :tokens, :token_info
  end

  devise_for :users
  
  namespace :api do
    namespace :v1 do
      resources :keywords, only: :index
      get 'private/sample', to: 'private#sample'
    end
  end

  resources :public_items, only: :index
  resources :private_items, only: :index
end
