Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  resources :cars do
    collection do
      get :last_seen
      
    end
  end
  resources :features 
  


  resources :offers
  resources :wishlists
  resources :brands


  resources :dealers

  resources :users do 
    collection do
      post :login
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
    collection do
      patch :update_status
      get :booking_history

    end
  end

  resources :notifications
  resources :reviews


  resources :payments do 
    collection do 
      post :purchase_single_item
    end
  end

    resources :orders
    resources :order_items
    resources :subscriptions





  
end



