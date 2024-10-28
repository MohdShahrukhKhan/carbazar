# class ChatsController < ApplicationControllera
#   def create
#     customer = User.find(params[:customer_id])
#     dealer = User.find(params[:dealer_id])

#     # Ensure roles are correct
#     if customer.role == 'customer' && dealer.role == 'dealer'
#       chat = Chat.find_or_create_by(customer: customer, dealer: dealer)
#       render json: { chat_id: chat.id }, status: :created
#     else
#       render json: { error: 'Invalid customer or dealer' }, status: :unprocessable_entity
#     end
#   end

#   def show
#     chat = Chat.find(params[:id])
#     render json: chat, include: :messages
#   end
# end


class ChatsController < ApplicationController
  before_action :authenticate_user

  

  def create
    # Determine the current user role and find the other participant
    if current_user.role == 'customer'
      dealer = User.find(params[:dealer_id])
      if dealer.role == 'dealer'
        chat = Chat.find_or_create_by(customer: current_user, dealer: dealer)
        render json: { chat_id: chat.id }, status: :created
      else
        render json: { error: 'Invalid dealer' }, status: :unprocessable_entity
      end
    elsif current_user.role == 'dealer'
      customer = User.find(params[:customer_id])
      if customer.role == 'customer'
        chat = Chat.find_or_create_by(customer: customer, dealer: current_user)
        render json: { chat_id: chat.id }, status: :created
      else
        render json: { error: 'Invalid customer' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid user role' }, status: :unprocessable_entity
    end
  end

  def show
    chat = Chat.find(params[:id])

    # Ensure the current user is a participant in the chat
    if chat.customer == current_user || chat.dealer == current_user
      render json: chat, include: :messages
    else
      render json: { error: 'You do not have permission to view this chat' }, status: :forbidden
    end
  end

  private

  def authenticate_user
    # Placeholder method - replace with your actual authentication logic
    render json: { error: 'User not authenticated' }, status: :unauthorized unless current_user
  end
end
