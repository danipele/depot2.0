Rails.application.routes.draw do
  root 'store#index', as: 'store_index'

  resources :products
  resources :carts
  resources :line_items
  resources :orders
  resources :products do
    get :who_bought, on: :member
  end
end
