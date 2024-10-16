# # require 'rails_helper'
# # require 'ostruct'

# # RSpec.describe PaymentsController, type: :controller do
# #   let(:user) { create(:user) }
# #   let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }
# #   let(:headers) { { 'Token' => "Bearer #{token}" } }
# #   let!(:variant) { create(:variant, quantity: 10) }
# #   let!(:booking) { create(:booking, user: user, variant: variant, status: 'confirmed') } # Create a booking for most contexts

# #   before do
# #     request.headers['Token'] = "Bearer #{token}"
# #   end

# #   describe 'POST #purchase_single_item' do
# #     context 'when the item is in stock' do
# #       it 'creates an order, reduces the stock, and returns a successful response' do
# #         allow(Stripe::Customer).to receive(:create).and_return(OpenStruct.new(id: 'cust_12345'))
# #         allow(Stripe::Charge).to receive(:create).and_return(OpenStruct.new(paid: true))

# #         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

# #         expect(response).to have_http_status(:ok)
# #         expect(Order.count).to eq(1)
# #         expect(OrderItem.count).to eq(1)
# #         expect(OrderItem.first.quantity).to eq(1)
# #         expect(variant.reload.quantity).to eq(9) # Stock reduced by 1
# #       end
# #     end

# #     context 'when the item is out of stock' do
# #       before do
# #         variant.update(quantity: 0)
# #       end

# #       it 'returns an error' do
# #         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

# #         expect(response).to have_http_status(:unprocessable_entity)
# #         expect(JSON.parse(response.body)['error']).to eq('Insufficient stock available')
# #       end
# #     end

# #     context 'when purchasing more than available stock' do
# #       before do
# #         variant.update(quantity: 1) # Set available stock to 1
# #       end

# #       it 'returns an error' do
# #         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 2 }

# #         expect(response).to have_http_status(:unprocessable_entity)
# #         expect(JSON.parse(response.body)['error']).to eq('Insufficient stock available')
# #       end
# #     end

# #     context 'when the booking does not exist or is not confirmed' do
# #       it 'returns a forbidden error' do
# #         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: 999, quantity: 1 }

# #         expect(response).to have_http_status(:forbidden)
# #         expect(JSON.parse(response.body)['error']).to eq('You do not have a confirmed booking for this variant.')
# #       end
# #     end

# #     context 'when the total amount is invalid' do
# #       it 'returns an error for invalid total amount' do
# #         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 0 } # Invalid quantity

# #         expect(response).to have_http_status(:unprocessable_entity)
# #         expect(JSON.parse(response.body)['error']).to eq('Invalid quantity or item not available')
# #       end
# #     end

# #     context 'when the payment fails' do
# #       before do
# #         allow(Stripe::Charge).to receive(:create).and_return(OpenStruct.new(paid: false))
# #       end

# #       it 'returns an error message when payment fails' do
# #         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

# #         expect(response).to have_http_status(:unprocessable_entity)
# #         expect(JSON.parse(response.body)['error']).to eq('Payment failed')
# #       end
# #     end

# #     context 'when there is a Stripe card error' do
# #       it 'rescues from Stripe::CardError and returns the error message' do
# #         allow(Stripe::Charge).to receive(:create).and_raise(Stripe::CardError.new('Card error message', nil, nil))

# #         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

# #         expect(response).to have_http_status(:unprocessable_entity)
# #         expect(JSON.parse(response.body)['error']).to eq('Card error message')
# #       end
# #     end
# #   end
# # end






# require 'rails_helper'
# require 'ostruct'

# RSpec.describe PaymentsController, type: :controller do
#   let(:user) { create(:user) }
#   let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }
#   let!(:variant) { create(:variant, quantity: 10) }
#   let!(:booking) { create(:booking, user: user, variant: variant, status: 'confirmed') }

#   before do
#     request.headers['Token'] = "Bearer #{token}"
#   end

#   describe 'POST #purchase_single_item' do
#     context 'when the item is in stock' do
#       it 'creates an order, reduces the stock, and returns a successful response' do
#         allow(Stripe::Customer).to receive(:create).and_return(OpenStruct.new(id: 'cust_12345'))
#         allow(Stripe::Charge).to receive(:create).and_return(OpenStruct.new(paid: true))

#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

#         expect(response).to have_http_status(:ok)
#         expect(Order.count).to eq(1)
#         expect(OrderItem.count).to eq(1)
#         expect(OrderItem.first.quantity).to eq(1)
#         expect(variant.reload.quantity).to eq(9)
#       end
#     end

#     context 'when the item is out of stock' do
#       before { variant.update(quantity: 0) }

#       it 'returns an error' do
#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['error']).to eq('Insufficient stock available')
#       end
#     end

#     context 'when purchasing more than available stock' do
#       before { variant.update(quantity: 1) }

#       it 'returns an error' do
#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 2 }

#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['error']).to eq('Insufficient stock available')
#       end
#     end

#     context 'when the booking does not exist or is not confirmed' do
#       it 'returns a forbidden error' do
#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: 999, quantity: 1 }

#         expect(response).to have_http_status(:forbidden)
#         expect(JSON.parse(response.body)['error']).to eq('You do not have a confirmed booking for this variant.')
#       end
#     end

#     context 'when the quantity is invalid' do
#       it 'returns an error for zero quantity' do
#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 0 }
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['error']).to eq('Invalid quantity or item not available')
#       end

#       it 'returns an error for exceeding available stock' do
#         variant.update(quantity: 1)
#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 2 }
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['error']).to eq('Insufficient stock available')
#       end
#     end

#     context 'when the payment fails' do
#       before { allow(Stripe::Charge).to receive(:create).and_return(OpenStruct.new(paid: false)) }

#       it 'returns an error message when payment fails' do
#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['error']).to eq('Payment failed')
#       end
#     end

#     context 'when there is a Stripe card error' do
#       it 'rescues from Stripe::CardError and returns the error message' do
#         allow(Stripe::Charge).to receive(:create).and_raise(Stripe::CardError.new('Card error message', nil, nil))

#         post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['error']).to eq('Card error message')
#       end
#     end
#   end
# end



require 'rails_helper'
require 'ostruct'

RSpec.describe PaymentsController, type: :controller do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }
  let(:headers) { { 'Token' => "Bearer #{token}" } }
  let!(:variant) { create(:variant, quantity: 10) }
  let!(:booking) { create(:booking, user: user, variant: variant, status: 'confirmed') }

  before do
    request.headers['Token'] = "Bearer #{token}"
  end

  describe 'POST #purchase_single_item' do
    context 'when the item is in stock' do
      it 'creates an order, reduces the stock, and returns a successful response' do
        allow(Stripe::Customer).to receive(:create).and_return(OpenStruct.new(id: 'cust_12345'))
        allow(Stripe::Charge).to receive(:create).and_return(OpenStruct.new(paid: true))

        post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

        expect(response).to have_http_status(:ok)
        expect(Order.count).to eq(1)
        expect(OrderItem.count).to eq(1)
        expect(OrderItem.first.quantity).to eq(1)
        expect(variant.reload.quantity).to eq(9) # Stock reduced by 1
      end
    end

    context 'when the item is out of stock' do
      before do
        variant.update(quantity: 0)
      end

      it 'returns an error' do
        post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Insufficient stock available')
      end
    end

    context 'when purchasing more than available stock' do
      before do
        variant.update(quantity: 1) # Set available stock to 1
      end

      it 'returns an error' do
        post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 2 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Insufficient stock available')
      end
    end

    context 'when the booking does not exist or is not confirmed' do
      it 'returns a forbidden error' do
        post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: 999, quantity: 1 }

        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)['error']).to eq('You do not have a confirmed booking for this variant.')
      end
    end

    context 'when the total amount is invalid' do
      it 'returns an error for invalid total amount' do
        post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 0 } # Invalid quantity

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid quantity or item not available')
      end
    end

    context 'when the payment fails' do
      before do
        allow(Stripe::Charge).to receive(:create).and_return(OpenStruct.new(paid: false))
      end

      it 'returns an error message when payment fails' do
        post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Payment failed')
      end
    end

    context 'when there is a Stripe card error' do
      it 'rescues from Stripe::CardError and returns the error message' do
        allow(Stripe::Charge).to receive(:create).and_raise(Stripe::CardError.new('Card error message', nil))

        post :purchase_single_item, params: { email: user.email, token: 'tok_visa', booking_id: booking.id, quantity: 1 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Card error message')
      end
    end
  end
end

