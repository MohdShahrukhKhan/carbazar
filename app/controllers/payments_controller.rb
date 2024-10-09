class PaymentsController < ApplicationController
  before_action :find_variant_from_booking, only: [:purchase_single_item]

  def purchase_single_item
    total_amount = apply_subscription_discount(@variant_price * @quantity_to_purchase)

    customer = create_stripe_customer(params[:email], params[:token])
    charge = create_stripe_charge(customer.id, total_amount, "Purchase of #{@variant.variant}")

    if charge.paid
      @variant.update!(quantity: @variant.quantity - @quantity_to_purchase)

      order = create_order(@variant, total_amount, @quantity_to_purchase)
      render json: { message: 'Payment successful', order: order }, status: :ok
    else
      render json: { error: 'Payment failed' }, status: :unprocessable_entity
    end
  rescue Stripe::CardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  # Find the variant from the user's confirmed booking
  def find_variant_from_booking
    @booking = Booking.find_by(id: params[:booking_id], user_id: @current_user.id, status: 'confirmed')

    if @booking.nil?
      render json: { error: 'You do not have a confirmed booking for this variant.' }, status: :forbidden and return
    end

    @variant = @booking.variant
    @quantity_to_purchase = params[:quantity].to_i
    if @variant.quantity < @quantity_to_purchase
      render json: { error: 'Insufficient stock available' }, status: :unprocessable_entity and return
    end
    # Use discounted price if available, otherwise base price
    @variant_price = @variant.discounted_price || @variant.price
  end

  def apply_subscription_discount(price)
    if @current_user.subscription_active?
      # Apply 5% discount if user has an active subscription
      price -= (price * 0.05)
    end
    price
  end

  def create_order(variant, total_price, quantity)
    order = Order.create!(
      user_id: @current_user.id,
      total_price: total_price,
      status: 'paid'
    )
    OrderItem.create!(
      order_id: order.id,
      variant_id: variant.id,
      quantity: quantity,
      price: total_price / quantity # Store price per unit
    )
    order
  end

  def create_stripe_customer(email, token)
    Stripe::Customer.create(email: email, source: token)
  end

  def create_stripe_charge(customer_id, amount, description)
    Stripe::Charge.create(
      customer: customer_id,
      amount: (amount * 100).to_i, # Convert dollars to cents
      description: description,
      currency: 'usd'
    )
  end
end
