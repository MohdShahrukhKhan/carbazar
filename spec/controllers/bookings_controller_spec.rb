# require 'rails_helper'

# RSpec.describe BookingsController, type: :controller do
#   let(:user) { create(:user) }

#   let(:variant) { create(:variant) }  # This now works because a Car is automatically created

#   let!(:booking) { create(:booking, user: user, variant: variant) }

#   let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }

#   before do
#     # Simulate passing the token in the headers
#     request.headers['Token'] = "Bearer #{token}"
#   end

#   describe "GET #index" do
#     context "when user is authenticated" do
#       it "returns a successful response" do
#         get :index
#         expect(response).to have_http_status(:ok)
#       end

#       it "returns the user's bookings" do
#         get :index
#         json_response = JSON.parse(response.body)
#         expect(json_response.size).to eq(1) # Assuming there is one booking
#         expect(json_response[0]["id"]).to eq(booking.id)
#       end
#     end

#     context "when user is not authenticated" do
#       it "returns an unauthorized response" do
#         get :index
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end
#   end

#   describe "GET #show" do
#     context "when booking exists" do
#       it "returns the booking" do
#         get :show, params: { id: booking.id }
#         expect(response).to have_http_status(:ok)
#         json_response = JSON.parse(response.body)
#         expect(json_response["id"]).to eq(booking.id)
#       end
#     end

#     context "when booking does not exist" do
#       it "returns a not found response" do
#         get :show, params: { id: 999 }
#         expect(response).to have_http_status(:not_found)
#       end
#     end
#   end

#   describe "POST #create" do
#     context "when user is authenticated" do
#       context "with valid parameters" do
#         it "creates a new booking" do
#           expect {
#             post :create, params: { booking: { variant_id: variant.id, booking_date: DateTime.now, status: 'pending' } }
#           }.to change(Booking, :count).by(1)
#           expect(response).to have_http_status(:created)
#         end
#       end

#       context "with invalid parameters" do
#         it "returns an unprocessable entity response" do
#           post :create, params: { booking: { variant_id: nil, booking_date: nil, status: 'pending' } }
#           expect(response).to have_http_status(:unprocessable_entity)
#         end
#       end
#     end

#     context "when user is not authenticated" do
#       before { allow(controller).to receive(:current_user).and_return(nil) }

#       it "returns an unauthorized response" do
#         post :create, params: { booking: { variant_id: variant.id, booking_date: DateTime.now } }
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end
#   end

#   describe "GET #booking_history" do
#     context "when user is authenticated" do
#       it "returns confirmed bookings" do
#         booking.update(status: 'confirmed')
#         get :booking_history
#         expect(response).to have_http_status(:ok)
#         json_response = JSON.parse(response.body)
#         expect(json_response.size).to eq(1)
#       end
#     end

#     context "when user is not authenticated" do
#       before { allow(controller).to receive(:current_user).and_return(nil) }

#       it "returns an unauthorized response" do
#         get :booking_history
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end
#   end

#   describe "DELETE #destroy" do
#     context "when booking exists" do
#       it "deletes the booking" do
#         expect {
#           delete :destroy, params: { id: booking.id }
#         }.to change(Booking, :count).by(-1)
#         expect(response).to have_http_status(:ok)
#       end
#     end

#     context "when booking does not exist" do
#       it "returns a not found response" do
#         delete :destroy, params: { id: 999 }
#         expect(response).to have_http_status(:not_found)
#       end
#     end
#   end
# end



require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:variant) { create(:variant) }  # Ensure the variant is created with a valid associated car
  let!(:booking) { create(:booking, user: user, variant: variant) }
  let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }

  before do
    # Simulate passing the token in the headers for authenticated tests
    request.headers['Token'] = "Bearer #{token}"
  end

  describe "GET #index" do
    context "when user is authenticated" do
      it "returns a successful response" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "returns the user's bookings" do
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(1)  # Assuming there is one booking
        expect(json_response[0]["id"]).to eq(booking.id)
      end
    end

    context "when user is not authenticated" do
      before { request.headers['Token'] = nil }  # Clear the token to simulate unauthenticated access

      it "returns an unauthorized response" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #show" do
    context "when booking exists" do
      it "returns the booking" do
        get :show, params: { id: booking.id }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to eq(booking.id)
      end
    end

    context "when booking does not exist" do
      it "returns a not found response" do
        get :show, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    context "when user is authenticated" do
      context "with valid parameters" do
        it "creates a new booking" do
          expect {
            post :create, params: { booking: { variant_id: variant.id, booking_date: DateTime.now, status: 'pending' } }
          }.to change(Booking, :count).by(1)
          expect(response).to have_http_status(:created)
        end
      end

      context "with invalid parameters" do
        it "returns an unprocessable entity response" do
          post :create, params: { booking: { variant_id: nil, booking_date: nil, status: 'pending' } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when user is not authenticated" do
      before { request.headers['Token'] = nil }  # Clear the token

      it "returns an unauthorized response" do
        post :create, params: { booking: { variant_id: variant.id, booking_date: DateTime.now } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #booking_history" do
    context "when user is authenticated" do
      it "returns confirmed bookings" do
        booking.update(status: 'confirmed')  # Ensure the booking status is confirmed
        get :booking_history
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(1)
        expect(json_response[0]["id"]).to eq(booking.id)  # Ensure the returned booking matches
      end
    end

    context "when user is not authenticated" do
      before { request.headers['Token'] = nil }  # Clear the token

      it "returns an unauthorized response" do
        get :booking_history
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when booking exists" do
      it "deletes the booking" do
        expect {
          delete :destroy, params: { id: booking.id }
        }.to change(Booking, :count).by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when booking does not exist" do
      it "returns a not found response" do
        delete :destroy, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
