Rails.application.routes.draw do
  # Devise routes for users and admin users
  #devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  resources :cars
  resources :features do
  collection do 
   post :emi 
  end   
  end

  resources :offers
  resources :wishlists


  resources :dealers

  resources :users
  resources :colours


  
end



