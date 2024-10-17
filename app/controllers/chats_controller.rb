class ChatsController < ApplicationController
  def create
    customer = User.find(params[:customer_id])
    dealer = User.find(params[:dealer_id])

    # Ensure roles are correct
    if customer.role == 'customer' && dealer.role == 'dealer'
      chat = Chat.find_or_create_by(customer: customer, dealer: dealer)
      render json: { chat_id: chat.id }, status: :created
    else
      render json: { error: 'Invalid customer or dealer' }, status: :unprocessable_entity
    end
  end

  def show
    chat = Chat.find(params[:id])
    render json: chat, include: :messages
  end
end
