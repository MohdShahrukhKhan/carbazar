

class BookingsController < ApplicationController
   before_action :set_booking, only: [:show, :destroy, :index]
  # before_action :authenticate_user! # Assuming you're using Devise or a similar authentication system

  # GET /bookings
  def index
  if @current_user
    bookings = current_user.bookings.includes(:variant).order(created_at: :desc)
    render json: bookings, include: [:variant], status: :ok
  else
    render json: { error: 'User not authenticated' }, status: :unauthorized
  end
end

  # GET /bookings/:id
  def show
    if @booking
      render json: @booking, include: [:variant], status: :ok
    else
      render json: { error: 'Booking not found' }, status: :not_found
    end
  end

  # POST /bookings
  def create
    if current_user
      booking = current_user.bookings.build(booking_params)
      if booking.save
        render json: booking, status: :created
      else
        render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'User not authenticated' }, status: :unauthorized
    end
  end


  def booking_history
    if current_user
      bookings = current_user.bookings.includes(:variant).where(status: 'confirmed')
      render json: bookings, include: [:variant], status: :ok
    else
      render json: { error: 'User not authenticated' }, status: :unauthorized
    end
 end

  # DELETE /bookings/:id
  def destroy
    if @booking
      @booking.destroy
      render json: { message: 'Booking deleted successfully' }, status: :ok
    else
      render json: { error: 'Booking not found' }, status: :not_found
    end
  end

  private

  # Set booking for show and destroy actions
  def set_booking
    @booking = current_user.bookings.find_by(id: params[:id])
  end

  # Strong parameters for bookings
  def booking_params
    params.require(:booking).permit(:variant_id, :booking_date, :status)
  end
end
