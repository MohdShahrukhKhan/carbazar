require 'rails_helper'

RSpec.describe VariantsController, type: :controller do
  let(:user) { create(:user) }
  let!(:car) { create(:car) }  # Ensure you have a car factory set up
  let!(:variant) { create(:variant, car: car) } 
  let(:token) { JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256') }
   # Create a variant associated with the car

  before do
    # Simulate passing the token in the headers for authenticated tests
    request.headers['Token'] = "Bearer #{token}"
  end


  describe "GET #index" do
    it "returns a list of variants" do
      get :index
      expect(response).to have_http_status(:ok)  # Expect a 200 OK status
      json_response = JSON.parse(response.body)
      expect(json_response["variants"].size).to eq(1)  # Check the number of variants
    end
  end

  describe 'GET #show' do
    context 'when the variant does not exist' do
      it 'returns a 404 not found' do
        get :show, params: { id: 99999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Variant not found' })
      end
    end
  end

  describe "POST #create" do
    let(:valid_params) { { variant: { variant: "New Variant", price: 1000, colour: "Blue", car_id: car.id } } }

    it "creates a new variant" do
      expect {
        post :create, params: valid_params
      }.to change(Variant, :count).by(1)  # Expect count to increase by 1
      expect(response).to have_http_status(:created)  # Expect 201 Created
    end

    it "returns unprocessable entity for invalid params" do
      post :create, params: { variant: { variant: nil } }  # Invalid params
      expect(response).to have_http_status(:unprocessable_entity)  # Expect 422
    end
  end

  describe "PATCH #update" do
    let(:update_params) { { id: variant.id, variant: { price: 1500 } } }

    it "updates the variant" do
      patch :update, params: update_params
      expect(response).to have_http_status(:ok)  # Expect 200 OK
      expect(variant.reload.price).to eq("1500")  # Check the price is updated
    end

    it "returns unprocessable entity for invalid params" do
      patch :update, params: { id: variant.id, variant: { variant: nil } }
      expect(response).to have_http_status(:unprocessable_entity)  # Expect 422
    end
  end

  describe "DELETE #destroy" do
    it "deletes the variant" do
      expect {
        delete :destroy, params: { id: variant.id }
      }.to change(Variant, :count).by(-1)  # Expect count to decrease by 1
      expect(response).to have_http_status(:no_content)  # Expect 204 No Content
    end

    it "returns not found for non-existing variant" do
      delete :destroy, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)  # Expect 404
    end
  end

 describe "GET #emi" do
    let(:emi_params) { { id: variant.id, interest_rate: 10, tenure: 2 } }  # Example params

    it 'calculates EMI for the variant' do
      get :emi, params: { id: variant.id, interest_rate: 5, tenure: 12 }  # Valid tenure and interest_rate
      expect(response).to have_http_status(:ok)  # Expect 200 OK
      json_response = JSON.parse(response.body)
      expect(json_response['emi']).to be_present  # Ensure EMI is present
      expect(json_response['emi']).to be_a(Float)  # Check that EMI is a float
    end

    it "returns unprocessable entity for invalid tenure" do
      get :emi, params: { id: variant.id, interest_rate: 10, tenure: nil }  # Invalid tenure
      expect(response).to have_http_status(:unprocessable_entity)  # Expect 422
    end
  end
end
