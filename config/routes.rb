Rails.application.routes.draw do

  namespace :public do
    get 'cart_items/index'
  end
  devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',
    registrations: 'public/customers/registrations'
  }

  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations'
  }

  resources :genres

  namespace :admin do
  root to: 'homes#top'
  resources :items
  resources :customers
  resources :orders
  resources :order_details
  end

  namespace :public do
    get 'homes/top'
    get 'homes/about'
    # 会員
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch '/customers/withdrawal' => 'cus#withdrawal', as: 'withdrawal'
    resources :customers, only: [:show, :edit, :update, :destroy]
    # 配送先住所
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    # 商品
    resources :items, only: [:index, :show]
  end
end
