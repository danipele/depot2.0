Rails.application.routes.draw do
  resources :products
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
end
