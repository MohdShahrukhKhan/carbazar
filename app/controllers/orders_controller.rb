# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
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

  # POST /orders
  def create
    order = current_user.orders.build(order_params)

    if order.save
      render json: order, serializer: OrderSerializer, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /orders/:id
  def show
    render json: @order, serializer: OrderSerializer, status: :ok
  end

  # PATCH/PUT /orders/:id
  def update
    if @order.update(order_params)
      render json: @order, serializer: OrderSerializer, status: :ok
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /orders/:id
  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find_by(id: params[:id])
    render json: { error: 'Order not found' }, status: :not_found unless @order
  end

  def order_params
    params.require(:order).permit(:total_price, :status, order_items_attributes: [:variant_id, :quantity, :price])
  end
end
