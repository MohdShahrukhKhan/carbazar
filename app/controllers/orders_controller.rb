class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders, each_serializer: OrderSerializer, status: :ok
  end

  # POST /orders
  def create
    order = Order.new(order_params)

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
    params.require(:order).permit(:user_id, :total_price, :status, order_items_attributes: [:variant_id, :quantity, :price])
  end
end
