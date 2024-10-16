# require 'rails_helper'

# RSpec.describe CarsController, type: :controller do
#   let(:brand) { create(:brand) }
#   let!(:car) { create(:car, brand: brand) }
#   let(:user) { create(:user) }
#   let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }

#   before do
#     request.headers['Token'] = "Bearer #{token}"
#   end

#   describe 'GET #index' do
#     let!(:car1) { create(:car, brand: brand) }
#     let!(:car2) { create(:car, brand: brand) }

#     it 'returns a list of cars' do
#       get :index
#       expect(response).to have_http_status(:ok)

#       json_response = JSON.parse(response.body)

#       # Print the JSON response to check what is returned
#       puts json_response.inspect

#       expect(json_response['cars']).to be_present
#       expect(json_response['cars'].length).to eq(3)  # Expecting all cars including the newly created one
#       expect(json_response['cars'].map { |car| car['id'] }).to include(car.id, car1.id, car2.id)
#     end
#   end

#   describe 'GET #show' do
#     context 'when car exists' do
#       it 'returns the car details' do
#         get :show, params: { id: car.id }
#         expect(response).to have_http_status(:ok)
#         json_response = JSON.parse(response.body)
#         expect(json_response['name']).to eq(car.name)
#       end
#     end

#     context 'when car does not exist' do
#       it 'returns a 404 not found' do
#         get :show, params: { id: 99999 }
#         expect(response).to have_http_status(:not_found)
#         expect(JSON.parse(response.body)['error']).to eq('Car not found')
#       end
#     end
#   end

#   describe 'GET #last_seen' do
#     context 'when there are last seen cars' do
#       before do
#         session[:last_seen_cars] = [car.id]
#       end

#       it 'returns the last seen cars' do
#         get :last_seen
#         expect(response).to have_http_status(:ok)
#         json_response = JSON.parse(response.body)
#         expect(json_response.first['id']).to eq(car.id)
#       end
#     end

#     context 'when no cars have been viewed' do
#       it 'returns a message saying no cars viewed recently' do
#         get :last_seen
#         expect(response).to have_http_status(:ok)
#         expect(JSON.parse(response.body)['message']).to eq('No cars viewed recently')
#       end
#     end
#   end

#   describe 'POST #create' do
#     let(:valid_params) do
#       {
#         car: {
#           name: "Test Car",
#           brand_id: brand.id,
#           body_type: "SUV",
#           car_types: "New Car",
#           launch_date: "2024-10-15",
#           variants_attributes: [
#             { variant: 'Base Model', price: 30000, colour: 'Blue', quantity: '5' }
#           ]
#         }
#       }
#     end

#     it 'creates a new car with valid attributes' do
#       expect {
#         post :create, params: valid_params
#       }.to change(Car, :count).by(1)
#       expect(response).to have_http_status(:created)
#     end

#     it 'returns an error when given invalid parameters' do
#       post :create, params: { car: { name: nil } }
#       expect(response).to have_http_status(:unprocessable_entity)
#       expect(JSON.parse(response.body)['errors']).to be_present
#     end
#   end

#   describe 'PATCH #update' do
#     let(:update_params) do
#       { id: car.id, car: { name: 'Updated Car Name' } }
#     end

#     it 'updates the car when given valid parameters' do
#       patch :update, params: update_params
#       expect(response).to have_http_status(:ok)
#       expect(car.reload.name).to eq('Updated Car Name')
#     end

#     it 'returns an error when given invalid parameters' do
#       patch :update, params: { id: car.id, car: { name: nil } }
#       expect(response).to have_http_status(:unprocessable_entity)
#       expect(JSON.parse(response.body)['errors']).to be_present
#     end
#   end

#   describe 'DELETE #destroy' do
#     it 'deletes the car' do
#       expect {
#         delete :destroy, params: { id: car.id }
#       }.to change(Car, :count).by(-1)
#       expect(response).to have_http_status(:ok)
#     end

#     it 'returns a 404 if the car does not exist' do
#       delete :destroy, params: { id: 99999 }
#       expect(response).to have_http_status(:not_found)
#       expect(JSON.parse(response.body)['error']).to eq('Car not found')
#     end
#   end
# end



require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  let(:brand) { create(:brand) }
  let!(:car) { create(:car, brand: brand) }
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }

  before do
    request.headers['Token'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    let!(:car1) { create(:car, brand: brand) }
    let!(:car2) { create(:car, brand: brand) }

    it 'returns a list of cars' do
      get :index
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      puts json_response.inspect

      expect(json_response['cars']).to be_present
      expect(json_response['cars'].length).to eq(3)
      expect(json_response['cars'].map { |car| car['id'] }).to include(car.id, car1.id, car2.id)
    end
  end

  describe 'GET #show' do
    context 'when car exists' do
      it 'returns the car details' do
        get :show, params: { id: car.id }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['name']).to eq(car.name)
      end
    end

    context 'when car does not exist' do
      it 'returns a 404 not found' do
        get :show, params: { id: 99999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Car not found')
      end
    end
  end

  describe 'GET #last_seen' do
    context 'when there are last seen cars' do
      before do
        session[:last_seen_cars] = [car.id]
      end

      it 'returns the last seen cars' do
        get :last_seen
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.first['id']).to eq(car.id)
      end
    end

    context 'when no cars have been viewed' do
      it 'returns a message saying no cars viewed recently' do
        get :last_seen
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('No cars viewed recently')
      end
    end
  end

  describe 'POST #create' do
let(:valid_params) do
  {
    car: {
      name: "Test Car",
      brand_id: brand.id,
      body_type: "SUV",
      car_types: "New Car",
      launch_date: (Date.today + 1).to_s, # Ensure this is a future date
      variants_attributes: [
        { variant: 'Base Model', price: 30000, colour: 'Blue', quantity: 5 } # Ensure quantity is an integer
      ]
    }
  }
end

    it 'creates a new car with valid attributes' do
      expect {
        post :create, params: valid_params
      }.to change(Car, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it 'returns an error when given invalid parameters' do
      post :create, params: { car: { name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to be_present
    end

    it 'logs validation errors if car creation fails' do
      invalid_params = valid_params.deep_merge(car: { launch_date: (Date.today - 1).to_s }) # Past date
      post :create, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
      
      # This will help debug the error message
      puts JSON.parse(response.body)['errors'].inspect
    end
  end

  describe 'PATCH #update' do
    let(:update_params) do
      { id: car.id, car: { name: 'Updated Car Name' } }
    end

    it 'updates the car when given valid parameters' do
      patch :update, params: update_params
      expect(response).to have_http_status(:ok)
      expect(car.reload.name).to eq('Updated Car Name')
    end

    it 'returns an error when given invalid parameters' do
      patch :update, params: { id: car.id, car: { name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to be_present
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the car' do
      expect {
        delete :destroy, params: { id: car.id }
      }.to change(Car, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a 404 if the car does not exist' do
      delete :destroy, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Car not found')
    end
  end
end
