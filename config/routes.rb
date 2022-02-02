Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :products, only: [:show]
  resources :prints, only: [:create, :edit, :update] do
    collection do
      get :new_book
      get :new_photo
      get :new_frame
    end

  end
  resources :orders, only: [:index, :show, :update] do
    collection do
      patch :add_item
      patch :pay
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
