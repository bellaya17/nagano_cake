Rails.application.routes.draw do
  devise_for :admins

  resources :genres
  
  namespace :admin do
  resources :items
  end

end
