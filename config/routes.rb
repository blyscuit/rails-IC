Rails.application.routes.draw do
  devise_for :users
  
  namespace :api do
    namespace :v1 do
      resources :keywords, only: :index
    end
  end

  resources :public_items, only: :index
  resources :private_items, only: :index
end
