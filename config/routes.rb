Rails.application.routes.draw do
  
  devise_for :admins
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
  end
end
