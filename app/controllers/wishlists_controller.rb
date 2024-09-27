class WishlistsController < ApplicationController
  before_action :set_user

  def create
    # Find if the wishlist for the feature already exists for this user
    existing_wishlist = @user.wishlists.find_by(feature_id: wishlist_params[:feature_id])
    
    if existing_wishlist
      existing_wishlist.destroy
      render json: { message: 'Wishlist deleted successfully' }, status: :ok
    else
      # Build a new wishlist associated with the user
      wishlist = @user.wishlists.build(wishlist_params)
      if wishlist.save
        render json: { message: 'Wishlist created successfully', wishlist: wishlist }, status: :created
      else
        render json: { errors: wishlist.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  # Correctly extract the user_id from within the wishlist object in params
  def set_user
    @user = User.find(wishlist_params[:user_id])
  end

  # Strong parameters to ensure only the allowed parameters are passed
  def wishlist_params
    params.require(:wishlist).permit(:user_id, :feature_id)
  end
end

  

