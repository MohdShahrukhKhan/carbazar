# class BookingsController < ApplicationController
#   before_action :set_booking, only: [:show, :update, :destroy]
#  # before_action :authenticate_user!  # Ensure user is authenticated

#   def index
#     bookings = current_user.bookings.includes(:car, :variant)
#     render json: bookings, include: [:car, :variant], status: :ok
#   end

#   def show
#     render json: @booking, include: [:car, :variant], status: :ok
#   end

#   def create
#     booking = current_user.bookings.build(booking_params)  # Associate with current user
#     if booking.save
#       render json: booking, include: [:car, :variant], status: :created
#     else
#       render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   def update
#     if @booking.update(booking_params)
#       render json: @booking, include: [:car, :variant], status: :ok
#     else
#       render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   def destroy
#     @booking.destroy
#     head :no_content
#   end

#   private

#   def set_booking
#     @booking = current_user.bookings.find(params[:id])  # Find booking for current user
#   end

#   def booking_params
#     params.require(:booking).permit(:car_id, :variant_id, :status, :booking_date)
#   end
# end


class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update, :destroy]
  # before_action :authenticate_user!  # Ensure user is authenticated

  def index
    if params[:status].present?
      bookings = @current_user.bookings.where(status: params[:status]).includes(:car, :variant)
    else
      bookings = @current_user.bookings.includes(:car, :variant)
    end
    render json: bookings, include: [:car, :variant], status: :ok
  end

  def show
  render json: {
    booking: @booking,
    history: @booking.history,
    notifications: @booking.notifications # If you want to include notifications
  }
end

  def create
    booking = @current_user.bookings.build(booking_params)  # Associate with current user
    if booking.save
      render json: booking, include: [:car, :variant], status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end

  end

# def update_status
#   if @booking.update(status: params[:status])
#     # Create a notification for the user
#     Notification.create(user: @booking.user, booking: @booking, content: "Your booking status has been updated to #{params[:status]}")
#     # Add a record to history
#     @booking.history << { status: params[:status], updated_at: Time.current }
#     @booking.save
#     render json: @booking, status: :ok
#   else
#     render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
#   end
# end



  def update
    if @booking.update(booking_params)
      render json: @booking, include: [:car, :variant], status: :ok
    else
      render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    head :no_content
  end

  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])  # Find booking for current user
  end

  def booking_params
    params.require(:booking).permit(:car_id, :variant_id, :status, :booking_date)
  end
end

