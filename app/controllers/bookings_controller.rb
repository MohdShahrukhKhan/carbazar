

class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy, :index, :update_status]
  before_action :authorize_customer, only: [:create]
  before_action :authorize_dealer, only: [:update_status]

  # GET /bookings
def index
  if current_user
    case current_user.role
    when 'customer'
      # Customers see only their bookings
      bookings = current_user.bookings.includes(variant: :car).order(created_at: :desc)
      if bookings.any?
        render json: bookings, include: [:variant], status: :ok
      else
        render json: { message: 'You have no bookings.' }, status: :ok
      end
    when 'dealer'
      # Dealers see bookings related only to the variants of their cars
      dealer_variants = Variant.joins(:car).where(cars: { user_id: current_user.id }).pluck(:id)
      bookings = Booking.includes(:variant).where(variant_id: dealer_variants).order(created_at: :desc)
      if bookings.any?
        render json: bookings, include: [:variant], status: :ok
      else
        render json: { message: 'You have no bookings.' }, status: :ok
      end
    else
      render json: { error: 'Role not recognized' }, status: :unprocessable_entity
    end
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
        #notify_dealer(booking)
        render json: booking, status: :created
      else
        render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'User not authenticated' }, status: :unauthorized
    end
  end

  # GET /booking_history
def booking_history
  if current_user
    case current_user.role
    when 'customer'
      # Customers can only see their own confirmed bookings
      bookings = current_user.bookings.includes(:variant).where(status: 'confirmed')
      render json: bookings, include: [:variant], status: :ok

    when 'dealer'
      # Dealers can see confirmed bookings for variants of cars they own
      dealer_variant_ids = Variant.joins(:car).where(cars: { user_id: current_user.id }).pluck(:id)
      bookings = Booking.includes(:variant).where(variant_id: dealer_variant_ids, status: 'confirmed')
      render json: bookings, include: [:variant], status: :ok

    else
      render json: { error: 'Role not recognized' }, status: :unprocessable_entity
    end
  else
    render json: { error: 'User not authenticated' }, status: :unauthorized
  end
end


  # DELETE /bookings/:id
def destroy
  if current_user.role == 'customer'
    if @booking.status != 'confirmed'
      @booking.destroy
      render json: { message: 'Booking deleted successfully' }, status: :ok
    else
      render json: { error: 'Confirmed bookings cannot be deleted' }, status: :forbidden
    end
  else
    render json: { error: 'Only customers can delete bookings' }, status: :unauthorized
  end
end


  

 def update_status
  if current_user.role == 'dealer' && @booking.variant.car.user_id == current_user.id
    if @booking.update(status: params[:status])
      render json: { message: "Booking status updated to #{params[:status]}" }, status: :ok
    else
      render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
    end
  else
    render json: { error: 'Not authorized to update this booking' }, status: :unauthorized
  end
end


  private

  # Set booking for show, destroy, and update_status actions
  # def set_booking
  #   @booking = current_user.bookings.find_by(id: params[:id])
  # end

  # Set booking for show, destroy, and update_status actions
def set_booking
  if current_user.role == 'customer'
    @booking = current_user.bookings.find_by(id: params[:id])
  elsif current_user.role == 'dealer'
    @booking = Booking.find_by(id: params[:id])
  end
end


  # Strong parameters for bookings
  def booking_params
    params.require(:booking).permit(:variant_id, :booking_date, :status)
  end

  # Ensure only customers can create bookings
  def authorize_customer
    unless current_user&.role == 'customer'
      render json: { error: "Only customers can create bookings" }, status: :forbidden
    end
  end

  # Ensure only dealers can update booking status
  def authorize_dealer
    unless current_user&.role == 'dealer'
      render json: { error: "Only dealers can update booking status" }, status: :forbidden
    end
  end

  # Notify dealer about new booking
  # def notify_dealer(booking)
  #   dealer = booking.variant.car.dealer
  #   # Make an API request to the dealer's system or use internal notification logic
  #   DealerNotifier.notify_booking_created(dealer, booking)
  # end
end

