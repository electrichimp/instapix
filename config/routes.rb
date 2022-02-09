Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "cart", to: 'pages#cart', as: :cart
  get "drafts", to: 'pages#drafts', as: :drafts
  get "about", to: 'pages#about_us', as: :about_us
  get "instagram", to: 'pages#instagram', as: :instagram
  resources :products, only: [:show] do
    resources :prints, only: [:new, :create]
    member do
      get "remember_product", to: 'products#remember_product', as: :remember
    end
  end
  resources :prints, only: [:edit, :update, :destroy] do
    collection do
      patch "upload_instagram", to: 'prints#upload_instagram', as: :upload_instagram
    end
    member do
      delete "trash/:key", to: 'prints#trash_pic', as: :trash
      get "remember_print", to: 'prints#remember_print', as: :remember
      patch :complete
    end
  end
  resources :orders, only: [:index, :show, :update] do
    collection do
      patch :add_item
    end
    member do
      patch :ship
      patch :pay
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
