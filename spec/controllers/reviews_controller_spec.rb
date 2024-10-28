# spec/controllers/reviews_controller_spec.rb
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:customer) { create(:user, :customer) }
  let(:dealer) { create(:user, :dealer) }
  let(:variant) { create(:variant) }

  describe 'GET #index' do
    let!(:review1) { create(:review, variant: variant) }
    let!(:review2) { create(:review, variant: variant) }
    let!(:review3) { create(:review) } # Review not linked to variant

    it 'returns all reviews when no variant_id is provided' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it 'returns only reviews for the specified variant' do
      get :index, params: { variant_id: variant.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST #create' do
    context 'when a customer is logged in' do
      before { sign_in customer }

      let(:valid_attributes) do
        {
          review: {
            rating: 5,
            variant_id: variant.id,
            comments_attributes: [
              { text: "Great product!" },
              { text: "Would buy again.", parent_comment_id: nil }
            ]
          }
        }
      end

      it 'creates a new review' do
        expect {
          post :create, params: { review: { rating: 5, variant_id: variant.id } }
        }.to change(Review, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'creates a review with nested comments' do
        expect {
          post :create, params: valid_attributes
        }.to change(Comment, :count).by(2)

        expect(response).to have_http_status(:created)
      end
    end

    context 'when a dealer is logged in' do
      before { sign_in dealer }

      it 'does not allow dealer to create a review' do
        post :create, params: { review: { rating: 5, variant_id: variant.id } }
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)['error']).to eq("Only customers can create reviews.")
      end
    end

    context 'when no user is logged in' do
      it 'does not allow creation of review' do
        post :create, params: { review: { rating: 5, variant_id: variant.id } }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when review creation fails' do
      before { sign_in customer }

      it 'returns error messages when invalid data is provided' do
        post :create, params: { review: { rating: nil, variant_id: variant.id } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include("rating" => ["can't be blank"])
      end
    end
  end
end
