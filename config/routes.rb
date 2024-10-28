# Rails.application.routes.draw do
  
#   devise_for :admin_users, ActiveAdmin::Devise.config
#   ActiveAdmin.routes(self)


#   resources :cars do
#     collection do
#       get :last_seen  # Get cars that were last seen
#       get :popular    # Get popular cars
#     end
#   end

#  get 'dealer/cars', to: 'users#dealer_cars'        # Dealer's car collection
#  get 'dealer/bookings', to: 'users#dealer_bookings' 

#   resources :features 

#   resources :chats, only: [:create, :show] do
#   resources :messages, only: [:create]
#   end

#   # WebSocket Cable requests
#   mount ActionCable.server => '/cable'


#   resources :offers
#   resources :wishlists


#   resources :brands do
#     collection do
#       get :popular
#     end
#   end



#   resources :users do 
#     collection do
#       post :login
#     end

# end


#   resources :colours
#   resources :plans
#   resources :variants do
#   collection do
#     get :emi # Use POST instead of GET
#     get 'popular' 
#   end
#   end

#  resources :bookings do
#   member do
#     patch :update_status  # Use `patch` to update a specific booking
#   end
#   collection do
#     get :booking_history  # Keep this as a collection route since it's for multiple bookings
#   end
# end

#    resources :notifications
# resources :reviews do
#   resources :comments, only: [:create, :index] do
#     member do
#       get 'replies'  # GET /reviews/:review_id/comments/:id/replies
#       post 'reply'   # POST /reviews/:review_id/comments/:id/reply
#     end
#   end
# end



#   resources :payments do 
#     collection do 
#       post :purchase_single_item
#     end
#   end

#     resources :orders
#     resources :order_items
#     resources :subscriptions

 
# end




Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :cars do
    collection do
      get :last_seen  # Get cars that were last seen
      get :popular    # Get popular cars
    end
  end

  # Dealer's routes
  get 'dealer/cars', to: 'users#dealer_cars'        # Dealer's car collection
  get 'dealer/bookings', to: 'users#dealer_bookings' # Dealer's booking collection 

  resources :features 
  resources :chats, only: [:create, :show] do
    resources :messages, only: [:create]
  end

  # WebSocket Cable requests
  mount ActionCable.server => '/cable'

  resources :offers
  resources :wishlists

  resources :brands do
    collection do
      get :popular
    end
  end

  resources :users do 
    collection do
      post :login
    end
  end

  resources :colours
  resources :plans
  resources :variants do
    collection do
      get :emi # Use POST instead of GET
      get :popular 
    end
  end

  resources :bookings do
    member do
      patch :update_status  # Use `patch` to update a specific booking
    end
    collection do
      get :booking_history  # Keep this as a collection route since it's for multiple bookings
    end
  end

  resources :notifications
  resources :reviews do
    resources :comments, only: [:create, :index] do
      member do
        get 'replies'  # GET /reviews/:review_id/comments/:id/replies
        post 'reply'   # POST /reviews/:review_id/comments/:id/reply
      end
    end
  end

  resources :payments do 
    collection do 
      post :purchase_single_item
    end
  end

  resources :orders
  resources :order_items, only: [:index, :show]
  resources :subscriptions
end



