class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :update, :destroy]

  # GET /order_items
  def index
    @order_items = OrderItem.all

    # Calculate total quantity and total price of all order items
    total_quantity = @order_items.sum(:quantity)
    total_price = @order_items.sum("quantity * price")

    render json: {
      order_items: @order_items,
      total_quantity: total_quantity,
      total_price: total_price
    }, each_serializer: OrderItemSerializer, status: :ok
  end

  # POST /order_items
  def create
    order_item = OrderItem.new(order_item_params)

    if order_item.save
      render json: order_item, serializer: OrderItemSerializer, status: :created
    else
      render json: { errors: order_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /order_items/:id
  def show
    render json: @order_item, serializer: OrderItemSerializer, status: :ok
  end

  # PATCH/PUT /order_items/:id
  def update
    if @order_item.update(order_item_params)
      render json: @order_item, serializer: OrderItemSerializer, status: :ok
    else
      render json: { errors: @order_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /order_items/:id
  def destroy
    @order_item.destroy
    head :no_content
  end

  private

  def set_order_item
    @order_item = OrderItem.find_by(id: params[:id])
    render json: { error: 'Order Item not found' }, status: :not_found unless @order_item
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :variant_id, :quantity, :price)
  end
end
