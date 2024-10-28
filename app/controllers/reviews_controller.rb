# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :ensure_customer, only: [:create, :index]

  def index
    if params[:variant_id]
      @reviews = Review.where(variant_id: params[:variant_id])
    else
      @reviews = Review.all
    end

    render json: @reviews, each_serializer: ReviewSerializer
  end

  # def create
  #   @review = current_user.reviews.new(review_params)

  #   # Ensure nested comments belong to the current user
  #   if review_params[:comments_attributes]
  #     @review.comments.each { |comment| comment.user = current_user }
  #   end

  #   if @review.save
  #     render json: @review, status: :created
  #   else
  #     render json: @review.errors, status: :unprocessable_entity
  #   end
  # end



  def create
  @review = current_user.reviews.new(review_params)

  # Ensure nested comments belong to the current user
  if review_params[:comments_attributes].present?
    review_params[:comments_attributes].each do |comment_attributes|
      # Assign the current user to each nested comment
      comment_attributes[:user_id] = current_user.id
    end
  end

  if @review.save
    render json: @review, status: :created
  else
    render json: @review.errors, status: :unprocessable_entity
  end
end


  private

  def review_params
    params.require(:review).permit(:rating, :variant_id, comments_attributes: [:text, :parent_comment_id])
  end

  def ensure_customer
    unless current_user&.customer?
      render json: { error: "Only customers can create reviews." }, status: :forbidden
    end
  end
end



# # app/controllers/reviews_controller.rb
# class ReviewsController < ApplicationController
#   # Ensure user is authenticated for creating a review if needed

#   def index
#     if params[:variant_id]
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
#     params.require(:review).permit(:rating, :comment, :variant_id)
#   end
# end
