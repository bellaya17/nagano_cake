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
    resources :customers
    get 'homes/top'
    get 'homes/about'
    get '/customers/unsubscribe'
  end
end
