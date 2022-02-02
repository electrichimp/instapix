Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/test", to: 'pages#test'
  resources :products, only: [:show] do
    resources :prints, only: [:new, :create]
  end
  resources :prints, only: [:edit, :update] do
  end
  resources :orders, only: [:index, :show, :update] do
    collection do
      patch :add_item
      patch :pay
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
