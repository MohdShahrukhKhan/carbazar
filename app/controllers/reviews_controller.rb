# # app/controllers/reviews_controller.rb
# class ReviewsController < ApplicationController
#   def index
#     if params[:car_id]
#       @reviews = Review.where(car_id: params[:car_id])
#     elsif params[:variant_id]
#       @reviews = Review.where(variant_id: params[:variant_id])
#     else
#       @reviews = Review.all
#     end

#     render json: @reviews, each_serializer: ReviewSerializer
#   end

#   def create
#     @review = Review.new(review_params.merge(user_id: current_user.id))

#     if @review.save
#       render json: @review, status: :created
#     else
#       render json: @review.errors, status: :unprocessable_entity
#     end
#   end

#   private

#   def review_params
#     params.require(:review).permit(:rating, :comment, :car_id, :variant_id)
#   end
# end


# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:create] # Ensure user is authenticated for creating a review

  def index
    if params[:car_id]
      @reviews = Review.where(car_id: params[:car_id])
    elsif params[:variant_id]
      @reviews = Review.where(variant_id: params[:variant_id])
    else
      @reviews = Review.all
    end

    render json: @reviews, each_serializer: ReviewSerializer
  end

  def create
    @review = Review.new(review_params.merge(user_id: current_user.id))

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :car_id, :variant_id)
  end
end
