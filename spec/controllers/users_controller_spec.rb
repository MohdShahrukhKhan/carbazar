


require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user, password: 'password123') }
  
  # Assuming you have a method to encode the token
  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end
  
  let(:token) { encode_token(user_id: user.id) }

describe 'GET #index' do
  before do
    request.headers['Token'] = "Bearer #{token}"
  end

  


  it 'returns all users' do
    get :index
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to include('id' => user.id)
  end
end


  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { user: { name: 'John Doe', email: 'john@example.com', password: 'password123' } } }

      it 'creates a new user' do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'returns a success message' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created) # Adjust based on your controller's response
        expect(JSON.parse(response.body)['message']).to eq('user created') # Adjust based on your controller's response
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { user: { name: '', email: '', password: '' } } }

      it 'does not create a user' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(User, :count)
      end

      it 'returns error messages' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank", "Email can't be blank", "Password can't be blank") 
      end
    end
  end

  describe 'POST #login' do
    context 'with valid credentials' do
      it 'authenticates the user and returns a token' do
        post :login, params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
        expect(JSON.parse(response.body)['message']).to eq('login successfully')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post :login, params: { email: user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
      end
    end
  end




describe 'PUT #update' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          id: user.id,
          user: {
            name: 'Updated Name',
            email: 'updated_email@example.com',
            password: 'new_password'
          }
        }
      end

      it 'updates the user and returns a success message' do
        put :update, params: valid_params
        user.reload

        expect(response).to have_http_status(:ok)
        expect(json_response['message']).to eq('User updated')
        expect(json_response['data']['name']).to eq('Updated Name')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          id: user.id,
          user: {
            name: '',
            email: 'invalid_email', # assuming email format validation is present
            password: ''
          }
        }
      end

      it 'does not update the user and returns error messages' do
        put :update, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).to include("Name can't be blank", "Email is invalid", "Password can't be blank")
      end
    end

    context 'when user does not exist' do
      it 'returns a not found error' do
        put :update, params: { id: 'non-existent-id', user: { name: 'Name' } }

        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('User not found')
      end
    end
  end


  describe 'DELETE #destroy' do
    context 'when the user exists' do
      it 'deletes the user and returns a success message' do
        expect {
          delete :destroy, params: { id: user.id }
        }.to change(User, :count).by(-1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('User deleted')
      end
    end

    context 'when the user does not exist' do
      it 'returns a not found error' do
        expect {
          delete :destroy, params: { id: 0 } # Invalid ID
        }.to_not change(User, :count)

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User not found')
      end
    end
  end
  

  # Helper method to parse the JSON response.
  def json_response
    JSON.parse(response.body)
  end


end
