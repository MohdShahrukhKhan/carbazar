class WishlistsController < ApplicationController
  # before_action :set_user, only: %i[create index]

  def index
  pagy, wishlists = pagy(@current_user.wishlists, items: 10) # 10 items per page

  render json: {
    wishlists: ActiveModelSerializers::SerializableResource.new(wishlists, each_serializer: WishlistSerializer),
    meta: pagination_metadata(pagy) # Pagy metadata for pagination
  }, status: :ok
end

  

  # POST /wishlists
  def create
    existing_wishlist = @current_user.wishlists.find_by(variant_id: wishlist_params[:variant_id])

    if existing_wishlist
      existing_wishlist.destroy
      render json: { message: 'Wishlist removed successfully' }, status: :ok
    else
      wishlist = @current_user.wishlists.build(wishlist_params.except(:user_id))
      if wishlist.save
        render json: wishlist, serializer: WishlistSerializer, status: :created
      else
        render json: { errors: wishlist.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def set_user
    @user = User.find_by(id: wishlist_params[:user_id])
    render json: { error: 'User not found' }, status: :not_found if @user.nil?
  end

  def wishlist_params
    params.require(:wishlist).permit(:car_id, :variant_id)
  end
end
