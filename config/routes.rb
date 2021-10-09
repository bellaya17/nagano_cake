Rails.application.routes.draw do



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
    root to: 'homes#top'
    get '/homes/about'
    # 会員
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit, :update, :destroy]



    # 配送先住所
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    # 商品
    resources :items, only: [:index, :show]
    # カート内商品
    delete 'cart_items_destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]

    # 注文
    get "orders/thanks" => "orders#thanks"
    post "orders/confirm" => "orders#confirm"
    resources :orders


  end
end
