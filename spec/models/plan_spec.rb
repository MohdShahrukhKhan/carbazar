# require 'rails_helper'

# RSpec.describe Plan, type: :model do
#   describe 'associations' do
#     it { should have_many(:subscriptions) }
#   end

#   describe 'validations' do
#     context 'when plan type is paid' do
#       let(:paid_plan) { Plan.new(plan_type: 'paid') }

#       it 'validates presence of price_monthly' do
#         paid_plan.price_monthly = nil
#         expect(paid_plan).not_to be_valid
#         expect(paid_plan.errors[:price_monthly]).to include("can't be blank")
#       end

#       it 'validates presence of price_yearly' do
#         paid_plan.price_yearly = nil
#         expect(paid_plan).not_to be_valid
#         expect(paid_plan.errors[:price_yearly]).to include("can't be blank")
#       end

#       it 'validates presence of discount' do
#         paid_plan.discount = nil
#         expect(paid_plan).not_to be_valid
#         expect(paid_plan.errors[:discount]).to include("can't be blank")
#       end

#       it 'validates presence of discount_type' do
#         paid_plan.discount_type = nil
#         expect(paid_plan).not_to be_valid
#         expect(paid_plan.errors[:discount_type]).to include("can't be blank")
#       end

#       it 'validates presence of discount_percentage' do
#         paid_plan.discount_percentage = nil
#         expect(paid_plan).not_to be_valid
#         expect(paid_plan.errors[:discount_percentage]).to include("can't be blank")
#       end
#     end

#     context 'when plan type is free' do
#       let(:free_plan) { build(:plan, :free, name: 'Free Plan') } # Ensure name is set

#       it 'does not validate presence of price_monthly or price_yearly' do
#         expect(free_plan).to be_valid
#         expect(free_plan.price_monthly).to be_nil
#         expect(free_plan.price_yearly).to be_nil
#       end

#       it 'does not validate presence of discount, discount_type, or discount_percentage' do
#         free_plan.discount = nil
#         free_plan.discount_type = nil
#         free_plan.discount_percentage = nil
#         expect(free_plan).to be_valid
#       end
#     end
#   end

#   describe '#paid_plan?' do
#     it 'returns true if plan type is paid' do
#       paid_plan = Plan.new(plan_type: 'paid')
#       expect(paid_plan.paid_plan?).to be true
#     end

#     it 'returns false if plan type is free' do
#       free_plan = Plan.new(plan_type: 'free')
#       expect(free_plan.paid_plan?).to be false
#     end
#   end

#   # describe 'discounted prices' do
#   #   let(:paid_plan) { Plan.new(plan_type: 'paid', price_monthly: 100, price_yearly: 1200) }

#   #   # context '#discounted_price_monthly' do
#   #   #   it 'returns the discounted monthly price with percentage discount' do
#   #   #     paid_plan.discount_type = 'Percentage'
#   #   #     paid_plan.discount_percentage = 10
#   #   #     expect(paid_plan.discounted_price_monthly).to eq(90)
#   #   #   end


#   #       it 'returns the discounted monthly price with percentage discount' do
#   #     paid_plan.discount_type = 'Percentage'
#   #     paid_plan.discount_percentage = 10
#   #     expect(paid_plan.discounted_price_monthly).to eq(90)
    


#   #     it 'returns the discounted monthly price with fixed discount' do
#   #       paid_plan.discount_type = 'Fixed'
#   #       paid_plan.discount_percentage = 10
#   #       expect(paid_plan.discounted_price_monthly).to eq(90)
#   #     end

#   #     it 'returns the original monthly price when no discount is applied' do
#   #       paid_plan.discount = false
#   #       expect(paid_plan.discounted_price_monthly).to eq(100)
#   #     end
#   #   end\

#    describe 'discounted prices' do
#     let(:paid_plan) { Plan.new(plan_type: 'paid', price_monthly: 100, price_yearly: 1200, discount: true) }

#     context '#discounted_price_monthly' do
#       it 'returns the discounted monthly price with percentage discount' do
#         paid_plan.discount_type = 'Percentage'
#         paid_plan.discount_percentage = 10
#         expect(paid_plan.discounted_price_monthly).to eq(90)
#       end

#       it 'returns the discounted monthly price with fixed discount' do
#         paid_plan.discount_type = 'Fixed'
#         paid_plan.discount_percentage = 10
#         expect(paid_plan.discounted_price_monthly).to eq(90)
#       end

#       it 'returns the original monthly price when no discount is applied' do
#         paid_plan.discount = false
#         expect(paid_plan.discounted_price_monthly).to eq(100)
#       end
#     end

#     context '#discounted_price_yearly' do
#       it 'returns the discounted yearly price with percentage discount' do
#         paid_plan.discount_type = 'Percentage'
#         paid_plan.discount_percentage = 10
#         expect(paid_plan.discounted_price_yearly).to eq(1080)
#       end

#       it 'returns the discounted yearly price with fixed discount' do
#         paid_plan.discount_type = 'Fixed'
#         paid_plan.discount_percentage = 100
#         expect(paid_plan.discounted_price_yearly).to eq(1100)
#       end

#       it 'returns the original yearly price when no discount is applied' do
#         paid_plan.discount = false
#         expect(paid_plan.discounted_price_yearly).to eq(1200)
#       end
#     end
#   end

#   describe 'ransackable_attributes' do
#     it 'includes all custom attributes for ransack' do
#       expected_attributes = [
#         'stripe_price_id', 'name', 'price_monthly', 'price_yearly',
#         'discount', 'discount_type', 'discount_percentage', 'active', 
#         'available', 'details', 'plan_type', 'months', 'limit_type', 
#         'limit', 'benefits', 'coming_soon'
#       ]
#       expect(Plan.ransackable_attributes).to include(*expected_attributes)
#     end
#   end
# end











require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'associations' do
    it { should have_many(:subscriptions) }
  end

  describe 'validations' do
    context 'when plan type is paid' do
      let(:paid_plan) { Plan.new(plan_type: 'paid') }

      it 'validates presence of price_monthly' do
        paid_plan.price_monthly = nil
        expect(paid_plan).not_to be_valid
        expect(paid_plan.errors[:price_monthly]).to include("can't be blank")
      end

      it 'validates presence of price_yearly' do
        paid_plan.price_yearly = nil
        expect(paid_plan).not_to be_valid
        expect(paid_plan.errors[:price_yearly]).to include("can't be blank")
      end

      it 'validates presence of discount' do
        paid_plan.discount = nil
        expect(paid_plan).not_to be_valid
        expect(paid_plan.errors[:discount]).to include("can't be blank")
      end

      it 'validates presence of discount_type' do
        paid_plan.discount_type = nil
        expect(paid_plan).not_to be_valid
        expect(paid_plan.errors[:discount_type]).to include("can't be blank")
      end

      it 'validates presence of discount_percentage' do
        paid_plan.discount_percentage = nil
        expect(paid_plan).not_to be_valid
        expect(paid_plan.errors[:discount_percentage]).to include("can't be blank")
      end
    end

    context 'when plan type is free' do
      let(:free_plan) { build(:plan, :free, name: 'Free Plan') }

      it 'does not validate presence of price_monthly or price_yearly' do
        expect(free_plan).to be_valid
        expect(free_plan.price_monthly).to be_nil
        expect(free_plan.price_yearly).to be_nil
      end

      it 'does not validate presence of discount, discount_type, or discount_percentage' do
        free_plan.discount = nil
        free_plan.discount_type = nil
        free_plan.discount_percentage = nil
        expect(free_plan).to be_valid
      end
    end
  end

  describe '#paid_plan?' do
    it 'returns true if plan type is paid' do
      paid_plan = Plan.new(plan_type: 'paid')
      expect(paid_plan.paid_plan?).to be true
    end

    it 'returns false if plan type is free' do
      free_plan = Plan.new(plan_type: 'free')
      expect(free_plan.paid_plan?).to be false
    end
  end

  describe 'discounted prices' do
    let(:paid_plan) { Plan.new(plan_type: 'paid', price_monthly: 100, price_yearly: 1200, discount: true) }

    context '#discounted_price_monthly' do
      it 'returns the discounted monthly price with percentage discount' do
        paid_plan.discount_type = 'Percentage'
        paid_plan.discount_percentage = 10
        expect(paid_plan.discounted_price_monthly).to eq(90)
      end

      it 'returns the discounted monthly price with fixed discount' do
        paid_plan.discount_type = 'Fixed'
        paid_plan.discount_percentage = 10
        expect(paid_plan.discounted_price_monthly).to eq(90)
      end

      it 'returns the original monthly price when no discount is applied' do
        paid_plan.discount = false
        expect(paid_plan.discounted_price_monthly).to eq(100)
      end
    end

    context '#discounted_price_yearly' do
      it 'returns the discounted yearly price with percentage discount' do
        paid_plan.discount_type = 'Percentage'
        paid_plan.discount_percentage = 10
        expect(paid_plan.discounted_price_yearly).to eq(1080)
      end

      it 'returns the discounted yearly price with fixed discount' do
        paid_plan.discount_type = 'Fixed'
        paid_plan.discount_percentage = 100
        expect(paid_plan.discounted_price_yearly).to eq(1100)
      end

      it 'returns the original yearly price when no discount is applied' do
        paid_plan.discount = false
        expect(paid_plan.discounted_price_yearly).to eq(1200)
      end
    end
  end

  describe 'ransackable_attributes' do
    it 'includes all custom attributes for ransack' do
      expected_attributes = [
        'stripe_price_id', 'name', 'price_monthly', 'price_yearly',
        'discount', 'discount_type', 'discount_percentage', 'active', 
        'available', 'details', 'plan_type', 'months', 'limit_type', 
        'limit', 'benefits', 'coming_soon'
      ]
      expect(Plan.ransackable_attributes).to include(*expected_attributes)
    end
  end
end
  
