Rails.application.routes.draw do
  root 'store#index', as: 'store_index'

  resources :products
  resources :carts
  resources :line_items
  resources :orders
  resources :users
  resources :products do
    get :who_bought, on: :member
  end
  get 'admin' => 'admin#index'
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
