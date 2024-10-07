# class PaymentsController < ApplicationController
# def purchase
#     # Find the booking to confirm payment
#     booking = Booking.find(params[:booking_id])
#     return render json: { error: 'Booking not found.' }, status: :not_found unless booking # Assuming you're passing booking_id in params

#     quantity_to_purchase  = params[:quantity].to_i
#     # Check if the booking is confirmed
#     if booking.status != 'confirmed'
#       return render json: { error: 'Payment can only be processed for confirmed bookings.' }, status: :unprocessable_entity
#     end

#     variant = booking.variant # Assuming there's an association in Booking model

#     if variant.quantity < quantity_to_purchase
#       return render json: { error: 'Insufficient stock available' }, status: :unprocessable_entity
#     end

#     total_amount = (variant.price * quantity_to_purchase).to_i


#     customer = Stripe::Customer.create(
#       email: params[:email],
#       source: params[:token]
#     )

#     charge = Stripe::Charge.create(
#       customer: customer.id,
#       amount: (total_amount * 100).to_i, # Amount in cents
#       description: "Payment for booking ID: #{booking.id}",
#       currency: 'usd'
#     )

#     if charge.paid
#       # Deduct stock and finalize the booking
#       reduce_variant_quantity(variant.id, quantity_to_purchase)

#       render json: { message: 'Payment successful', booking: booking }, status: :ok
#     else
#       render json: { error: 'Payment failed' }, status: :unprocessable_entity
#     end
#   rescue Stripe::CardError => e
#     render json: { error: e.message }, status: :unprocessable_entity
#   end

#   private

#   def reduce_variant_quantity(variant_id, quantity)
#     variant = Variant.find(variant_id)
#     variant.update(quantity: variant.quantity - quantity)
#   end
# end




class PaymentsController < ApplicationController
  def purchase
    # Find the booking to confirm payment
    booking = Booking.find(params[:booking_id])
    return render json: { error: 'Booking not found.' }, status: :not_found unless booking

    quantity_to_purchase = params[:quantity].to_i

    # Check if the booking is confirmed
    if booking.status != 'confirmed'
      return render json: { error: 'Payment can only be processed for confirmed bookings.' }, status: :unprocessable_entity
    end

    variant = booking.variant
    if variant.quantity < quantity_to_purchase
      return render json: { error: 'Insufficient stock available' }, status: :unprocessable_entity
    end

    total_amount = (variant.price.to_f * quantity_to_purchase.to_f)

    customer = Stripe::Customer.create(
      email: params[:email],
      source: params[:token]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: (total_amount * 100).to_i, # Amount in cents
      description: "Payment for booking ID: #{booking.id}",
      currency: 'usd'
    )

    if charge.paid
      # Deduct stock and finalize the booking
      reduce_variant_quantity(variant.id, quantity_to_purchase)

      # Create an order
      order = Order.create!(
        user_id: booking.user_id,
        total_price: total_amount,
        status: 'completed' # Set status to completed after successful payment
      )

      # Create the order item
      OrderItem.create!(
        order_id: order.id,
        variant_id: variant.id,
        quantity: quantity_to_purchase,
        price: variant.price
      )

      render json: { message: 'Payment and order successful', order: order, booking: booking }, status: :ok
    else
      render json: { error: 'Payment failed' }, status: :unprocessable_entity
    end
  rescue Stripe::CardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def reduce_variant_quantity(variant_id, quantity)
    variant = Variant.find(variant_id)
    variant.update(quantity: variant.quantity - quantity)
  end
end
