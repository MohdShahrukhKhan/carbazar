# # class SubscriptionsController < ApplicationController
# #   before_action :set_plan, only: [:create]
# #   before_action :set_variant, only: [:create]

# #   def create
# #     begin
# #       customer = find_or_create_stripe_customer(@current_user)

# #       payment_method_id = params[:payment_method_id]
# #       return render json: { error: "Payment method ID is required." }, status: :unprocessable_entity if payment_method_id.blank?

# #       Stripe::PaymentMethod.attach(payment_method_id, { customer: customer.id })
# #       Stripe::Customer.update(customer.id, invoice_settings: { default_payment_method: payment_method_id })

# #       # Calculate the final price with both catalogue variant and plan discounts
# #       final_price = calculate_final_price(@variant, @plan)

# #       payment_intent = Stripe::PaymentIntent.create({
# #         amount: (final_price * 100).to_i, # Amount in cents
# #         currency: 'usd',
# #         customer: customer.id,
# #         payment_method: payment_method_id,
# #         off_session: true,
# #         confirm: true,
# #       })

# #       Subscription.create(
# #         user: @current_user,
# #         plan: @plan,
# #         started_at: Time.current,
# #         expires_at: Time.current + @plan.months.months
# #       )

# #       render json: { message: 'Subscription created successfully', payment_intent: payment_intent }, status: :created
# #     rescue Stripe::StripeError => e
# #       Rails.logger.error("Stripe error: #{e.message}")
# #       render json: { error: e.message }, status: :unprocessable_entity
# #     rescue StandardError => e
# #       Rails.logger.error("Standard error: #{e.message}")
# #       render json: { error: 'An error occurred while creating the subscription' }, status: :internal_server_error
# #     end
# #   end

# #   private

# #   def set_plan
# #     @plan = Plan.find(params[:plan_id])
# #   end

# #   def set_variant
# #     @variant = Variant.find(params[:variant_id])
# #   end

# #   def find_or_create_stripe_customer(user)
# #     if user.stripe_customer_id.nil?
# #       create_stripe_customer(user)
# #     else
# #       Stripe::Customer.retrieve(user.stripe_customer_id)
# #     end
# #   end

# #   def create_stripe_customer(user)
# #     customer = Stripe::Customer.create({
# #       email: user.email,
# #       name: user.name,
# #     })

# #     user.update(stripe_customer_id: customer.id)
# #     customer
# #   end

# #   def calculate_final_price(variant, plan)
# #     # Get the discounted price of the catalogue variant
# #     variant_discounted_price = variant.discounted_price
    
# #     # Calculate the final price considering plan discount
# #     final_price = variant_discounted_price
# #     if plan.discount
# #       plan_discount_amount = (final_price * (plan.discount_percentage / 100.0))
# #       final_price -= plan_discount_amount
# #     end

# #     final_price
# #   end
# # end






# class SubscriptionsController < ApplicationController
#   before_action :set_plan, only: [:create]

#   def create
#     begin
#       puts @current_user.id
#       customer = find_or_create_stripe_customer(@current_user)

#       # Retrieve payment_method_id from params
#       payment_method_id = params[:payment_method_id]

#       # Check if payment method is provided
#       if payment_method_id.blank?
#         return render json: { error: "Payment method ID is required." }, status: :unprocessable_entity
#       end

#       # Attach the payment method to the customer
#       Stripe::PaymentMethod.attach(payment_method_id, { customer: customer.id })

#       # Set the payment method as the default for the customer
#       Stripe::Customer.update(customer.id, {
#         invoice_settings: {
#           default_payment_method: payment_method_id,
#         },
#       })

#       final_price = calculate_final_price(@plan) # Calculate final price with discounts

#       # Create a Payment Intent for the subscription
#       payment_intent = Stripe::PaymentIntent.create({
#         amount: (final_price * 100).to_i, # Amount in cents
#         currency: 'usd',
#         customer: customer.id,
#         payment_method: payment_method_id,
#         off_session: true,
#         confirm: true, # Automatically confirm the payment
#       })

#       # Create the subscription record in your database
#       Subscription.create(
#         user: @current_user,
#         plan: @plan,
#         started_at: Time.current,
#         expires_at: Time.current + @plan.months.months
#       )

#       render json: { message: 'Subscription created successfully', payment_intent: payment_intent }, status: :created
#     rescue Stripe::StripeError => e
#       Rails.logger.error("Stripe error: #{e.message}")
#       render json: { error: e.message }, status: :unprocessable_entity
#     rescue StandardError => e
#       Rails.logger.error("Standard error: #{e.message}")
#       render json: { error: 'An error occurred while creating the subscription' }, status: :internal_server_error
#     end
#   end

#   private

#   def set_plan
#     @plan = Plan.find(params[:plan_id])
#   end

#   def find_or_create_stripe_customer(user)
#     if user.stripe_customer_id.nil?
#       create_stripe_customer(user)
#     else
#       Stripe::Customer.retrieve(user.stripe_customer_id)
#     end
#   end

#   def create_stripe_customer(user)
#     customer = Stripe::Customer.create({
#       email: user.email,
#       name: user.name,
#     })

#     user.update(stripe_customer_id: customer.id)

#     customer
#   end

#   def calculate_final_price(plan)
#     final_price = plan.price_monthly
#     if plan.discount
#       final_price -= (final_price * (plan.discount_percentage / 100.0))
#       final_price = final_price * plan.months.to_i
#     end
#     final_price
#   end
# end

class SubscriptionsController < ApplicationController
  before_action :set_plan, only: [:create]
  
  def create
    # Check for existing active subscription
     if @current_user.subscription.present?
      return render json: { error: "You already have a subscription. Please upgrade your plan." }, status: :unprocessable_entity
    end

    customer = find_or_create_stripe_customer(@current_user)
    payment_method_id = params[:payment_method_id]

    # Check if payment method is provided
    if payment_method_id.blank?
      return render json: { error: "Payment method ID is required." }, status: :unprocessable_entity
    end

    # Attach payment method to Stripe customer
    Stripe::PaymentMethod.attach(payment_method_id, { customer: customer.id })
    Stripe::Customer.update(customer.id, {
      invoice_settings: {
        default_payment_method: payment_method_id,
      },
    })

    final_price = calculate_final_price(@plan)

    # Create Payment Intent for subscription
    payment_intent = Stripe::PaymentIntent.create({
      amount: (final_price * 100).to_i,
      currency: 'usd',
      customer: customer.id,
      payment_method: payment_method_id,
      off_session: true,
      confirm: true,
    })

    # Create subscription in the database
    subscription = Subscription.create(
      user: @current_user,
      plan: @plan,
      started_at: Time.current,
      expires_at: Time.current + @plan.months.months
    )

    render json: { message: 'Subscription created successfully', subscription: subscription, payment_intent: payment_intent }, status: :created
  rescue Stripe::StripeError => e
    Rails.logger.error("Stripe error: #{e.message}")
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    Rails.logger.error("Standard error: #{e.message}")
    render json: { error: 'An error occurred while creating the subscription' }, status: :internal_server_error
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def find_or_create_stripe_customer(user)
    if user.stripe_customer_id.nil?
      create_stripe_customer(user)
    else
      Stripe::Customer.retrieve(user.stripe_customer_id)
    end
  end

  def create_stripe_customer(user)
    customer = Stripe::Customer.create({
      email: user.email,
      name: user.name,
    })

    user.update(stripe_customer_id: customer.id)

    customer
  end

  def calculate_final_price(plan)
    final_price = plan.price_monthly
    if plan.discount
      final_price -= (final_price * (plan.discount_percentage / 100.0))
      final_price = final_price * plan.months.to_i
    end
    final_price
  end
end