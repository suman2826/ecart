Rails.application.routes.draw do
  devise_for :users, path: "", controllers: {
    confirmations: 'confirmations'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # api/categories
  # api/categories/:category_id/products

  namespace :api do
    resources :sessions, only: [:create]
    resources :users, only: [:create]
    
    resources :categories, only: [:index] do
      resources :products, only: [:index, :show]
    end

    resource :profile, only: [:show]
    resources :cart_items
    resources :orders, only: [:index, :create, :show]
  end
end