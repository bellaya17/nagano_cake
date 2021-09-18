Rails.application.routes.draw do
  devise_for :admins

  resources :genres

  namespace :admin do
  resources :items
  resources :customers
  resources :orders
  resources :order_details
  end

end
