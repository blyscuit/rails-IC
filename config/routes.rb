Rails.application.routes.draw do
  devise_for :users
  
  namespace :api do
    namespace :v1 do
      resources :keywords, only: :index
    end
  end

  resources :public, only: :index
  resources :private, only: :index
end
