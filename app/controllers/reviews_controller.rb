class ReviewsController < ApplicationController
    before_action :set_reviewable
    
    def create
      # Ensure @reviewable is set to a valid resource
      if @reviewable.nil?
        return render json: { error: 'Reviewable resource not found' }, status: :not_found
      end
    
      # Create the review associated with the reviewable resource
      @review = @reviewable.reviews.new(review_params)
      @review.user = current_user # Assuming you have current_user set up
    
      if @review.save
        render json: @review, status: :created
      else
        render json: @review.errors, status: :unprocessable_entity
      end
    end
  
    private
    def set_reviewable
        Rails.logger.debug("Reviewable params: #{params.inspect}")
        @reviewable = 
          if params[:new_car_id]
            NewCar.find_by(id: params[:new_car_id])
          elsif params[:upcoming_car_id]
            UpcomingCar.find_by(id: params[:upcoming_car_id])
          elsif params[:electric_car_id]
            ElectricCar.find_by(id: params[:electric_car_id])
          end
      end
      
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
  end
  