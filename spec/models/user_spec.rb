# require 'rails_helper'

# RSpec.describe User, type: :model do
#   subject { User.new(name: 'Test User', email: 'test@example.com', password: 'password') }

#   describe 'Validations' do
#     it { should validate_presence_of(:name) }
#     it { should validate_presence_of(:email) }
#     it { should validate_uniqueness_of(:email) }  # Check for uniqueness (case-sensitive)
#     it { should validate_presence_of(:password) }
#     it { should validate_length_of(:password).is_at_least(6) }


#   end

#   describe 'Associations' do
#     it { should have_many(:wishlists) }
#     it { should have_many(:bookings) }
#     it { should have_many(:notifications) }
#     it { should have_many(:reviews) }
#     it { should have_many(:orders) }
#     it { should have_one(:subscription) }
#   end

# describe '#subscription_active?' do
#   let(:plan) { Plan.create(plan_type: 'premium', price: 9.99) } # Create a valid plan
#   let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

#   context 'when subscription is active' do
#     it 'returns true' do
#       # Create a valid subscription with the required attributes
#       subscription = Subscription.new(
#         user: user,
#         plan: plan,  # Associate a valid plan
#         started_at: 1.day.ago,
#         expires_at: 1.day.from_now
#       )

#       # Save the subscription to the database
#       expect(subscription.save).to be true

#       # Assign the subscription to the user
#       user.subscription = subscription

#       # Ensure that the subscription is active
#       expect(user.subscription_active?).to be true
#     end
#   end
# end


# context 'when subscription is inactive' do
#   it 'returns false' do
#     subscription = Subscription.create(
#       user: user,
#       plan: plan,
#       started_at: 2.days.ago,
#       expires_at: 1.day.ago
#     )
#     user.subscription = subscription

#     expect(user.subscription_active?).to be false
#   end
# end

  

#   describe '.ransackable_attributes' do
#     it 'includes the expected attributes' do
#       expect(User.ransackable_attributes).to include('name', 'email', 'password', 'password_confirmation')
#     end
#   end
# end





require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Test User', email: 'test@example.com', password: 'password') }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(name: 'Another User', email: 'test@example.com', password: 'password')
      expect(subject).not_to be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with a short password' do
      subject.password = 'short'
      expect(subject).not_to be_valid
    end
  end

  describe '#subscription_active?' do
    let(:plan) do
      Plan.create(
        plan_type: 'paid', 
        price_monthly: 9.99, 
        price_yearly: 99.99, 
        name: 'Premium Plan',
        discount: 10,
        discount_type: 'Percentage',
        discount_percentage: 10
      )
    end
    
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

    context 'when subscription is active' do
      it 'returns true' do
        subscription = Subscription.new(
          user: user,
          plan: plan,
          started_at: 1.day.ago,
          expires_at: 1.day.from_now
        )
        expect(subscription.save).to be true
        user.subscription = subscription
        expect(user.subscription_active?).to be true
      end
    end

    context 'when subscription is not active' do
      it 'returns false' do
        subscription = Subscription.new(
          user: user,
          plan: plan,
          started_at: 1.day.ago,
          expires_at: 1.day.ago # Set the expiration in the past
        )
        expect(subscription.save).to be true
        user.subscription = subscription
        expect(user.subscription_active?).to be false
      end
    end

    context 'when there is no subscription' do
      it 'returns false' do
        expect(user.subscription_active?).to be false
      end
    end
  end
end
