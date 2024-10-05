Rails.application.routes.draw do
  # Devise routes for users and admin users
  #devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  resources :cars
  resources :features 
  


  resources :offers
  resources :wishlists
  resources :brands


  resources :dealers

  resources :users do 
    collection do
      post :login
      get :booking_history
    end

end


  resources :colours
  resources :plans
  resources :variants do
  member do
    get :emi # Use POST instead of GET
  end
  end

  resources :bookings do
    member do
      patch :update_status
    end
  end

  resources :notifications
  resources :reviews, only: [:index, :create]


 



  
end



