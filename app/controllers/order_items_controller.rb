# app/controllers/order_items_controller.rb
class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      @orders = if current_user.customer?
                  # Customers can see only their own orders
                  current_user.orders.includes(order_items: { variant: :car }).order(created_at: :desc)
                elsif current_user.dealer?
                  # Dealers can see orders that contain variants of cars they own
                  dealer_car_ids = Car.where(user_id: current_user.id).pluck(:id)
                  dealer_variant_ids = Variant.where(car_id: dealer_car_ids).pluck(:id)
                  Order.joins(order_items: :variant)
                       .includes(order_items: { variant: :car })
                       .where(order_items: { variant_id: dealer_variant_ids })
                       .distinct.order(created_at: :desc)
                else
                  render json: { error: 'Role not recognized' }, status: :unprocessable_entity and return
                end

      render json: @orders, each_serializer: OrderSerializer, status: :ok
    else
      render json: { error: 'User not authenticated' }, status: :unauthorized
    end
  end

  private

  # Assuming there's a method to check if the user is authenticated
  def authenticate_user!
    unless current_user
      render json: { error: 'User not authenticated' }, status: :unauthorized
    end
  end
end
