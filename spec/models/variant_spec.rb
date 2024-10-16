# require 'rails_helper'

# RSpec.describe Variant, type: :model do
#   let!(:brand) { Brand.create!(name: 'Test Brand') } # Ensure a Brand model exists

#   let!(:car) do
#     Car.create!(
#       name: 'Test Car',
#       brand: brand,
#       body_type: 'SUV', # Directly providing body type as a string
#       car_types: 'New Car' # Directly providing car types as a string
#     )
#   end

#   # Associations
#   it { should belong_to(:car) }
#   it { should have_many(:offers) }
#   it { should have_many(:wishlists) }
#   it { should have_many(:bookings) }
#   it { should have_one(:feature) }
#   it { should have_many(:reviews) }
#   it { should have_many(:order_items) }

#   # Validations
#   it { should validate_presence_of(:variant) }
#   it { should validate_uniqueness_of(:variant) }
#   it { should validate_presence_of(:price) }
#   it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
#   it { should validate_presence_of(:colour) }

#   describe 'associations' do
#     it 'is valid with a car' do
#       variant = Variant.new(
#         variant: 'Test Variant',
#         price: 100.0,
#         quantity: 5,  # Adding a valid quantity
#         colour: 'Red',  # Adding colour here
#         car: car # Associate with a car
#       )
#       expect(variant).to be_valid
#     end

#     it 'is invalid without a car' do
#       variant = Variant.new(
#         variant: 'Test Variant',
#         price: 100.0,
#         quantity: 5,
#         colour: 'Red'  # Adding colour here
#       )
#       expect(variant).not_to be_valid
#       expect(variant.errors[:car]).to include("must exist") # Adjust error message if needed
#     end
#   end

#   describe '#decrease_quantity' do
#     let!(:variant) { Variant.create!(variant: 'Test Variant', price: 100.0, quantity: 5, colour: 'Red', car: car) }

#     context 'when quantity is greater than 0' do
#       it 'decreases the quantity by 1' do
#         expect { variant.decrease_quantity }.to change { variant.reload.quantity }.by(-1)
#       end

#       it 'returns true' do
#         expect(variant.decrease_quantity).to be_truthy
#       end
#     end

#     context 'when quantity is 0' do
#       before { variant.update(quantity: 0) }

#       it 'does not change the quantity' do
#         expect { variant.decrease_quantity }.not_to change { variant.reload.quantity }
#       end

#       it 'returns false' do
#         expect(variant.decrease_quantity).to be_falsy
#       end
#     end
#   end

#   describe '#discounted_price' do
#     let!(:variant) { Variant.create!(variant: 'Test Variant', price: 100.0, quantity: 5, colour: 'Red', car: car) }
#     let!(:offer) { Offer.create!(variant: variant, discount: 20, start_date: Date.today - 1, end_date: Date.today + 1) }

#     context 'when there is an active offer' do
#       it 'calculates the discounted price' do
#         expect(variant.discounted_price).to eq(80.0) # 100 - (20% of 100)
#       end
#     end

#     context 'when there is no active offer' do
#       before { offer.destroy }

#       it 'returns the original price' do
#         expect(variant.discounted_price).to eq(100.0)require 'rails_helper'

# RSpec.describe Variant, type: :model do
#   let!(:brand) { Brand.create!(name: 'Test Brand') } # Ensure a Brand model exists

#   let!(:car) do
#     Car.create!(
#       name: 'Test Car',
#       brand: brand,
#       body_type: 'SUV', # Directly providing body type as a string
#       car_types: 'New Car' # Directly providing car types as a string
#     )
#   end

#   # Associations
#   it { should belong_to(:car) }
#   it { should have_many(:offers) }
#   it { should have_many(:wishlists) }
#   it { should have_many(:bookings) }
#   it { should have_one(:feature) }
#   it { should have_many(:reviews) }
#   it { should have_many(:order_items) }

#   # Validations
#   it { should validate_presence_of(:variant) }
#   it { should validate_uniqueness_of(:variant) }
#   it { should validate_presence_of(:price) }
#   it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
#   it { should validate_presence_of(:colour) }

#   describe 'associations' do
#     it 'is valid with a car' do
#       variant = Variant.new(
#         variant: 'Test Variant',
#         price: 100.0,
#         quantity: 5,  # Adding a valid quantity
#         colour: 'Red',  # Adding colour here
#         car: car # Associate with a car
#       )
#       expect(variant).to be_valid
#     end

#     it 'is invalid without a car' do
#       variant = Variant.new(
#         variant: 'Test Variant',
#         price: 100.0,
#         quantity: 5,
#         colour: 'Red'  # Adding colour here
#       )
#       expect(variant).not_to be_valid
#       expect(variant.errors[:car]).to include("must exist") # Adjust error message if needed
#     end
#   end

#   describe '#decrease_quantity' do
#     let!(:variant) { Variant.create!(variant: 'Test Variant', price: 100.0, quantity: 5, colour: 'Red', car: car) }

#     context 'when quantity is greater than 0' do
#       it 'decreases the quantity by 1' do
#         expect { variant.decrease_quantity }.to change { variant.reload.quantity }.by(-1)
#       end

#       it 'returns true' do
#         expect(variant.decrease_quantity).to be_truthy
#       end
#     end

#     context 'when quantity is 0' do
#       before { variant.update(quantity: 0) }

#       it 'does not change the quantity' do
#         expect { variant.decrease_quantity }.not_to change { variant.reload.quantity }
#       end

#       it 'returns false' do
#         expect(variant.decrease_quantity).to be_falsy
#       end
#     end
#   end

#   describe '#discounted_price' do
#     let!(:variant) { Variant.create!(variant: 'Test Variant', price: 100.0, quantity: 5, colour: 'Red', car: car) }
#     let!(:offer) { Offer.create!(variant: variant, discount: 20, start_date: Date.today - 1, end_date: Date.today + 1) }

#     context 'when there is an active offer' do
#       it 'calculates the discounted price' do
#         expect(variant.discounted_price).to eq(80.0) # 100 - (20% of 100)
#       end
#     end

#     context 'when there is no active offer' do
#       before { offer.destroy }

#       it 'returns the original price' do
#         expect(variant.discounted_price).to eq(100.0)
#       end
#     end
#   end

#   describe '.ransackable_attributes' do
#     it 'includes car_id in ransackable attributes' do
#       expect(Variant.ransackable_attributes).to include('car_id')
#     end
#   end
# end

#       end
#     end
#   end

#   describe '.ransackable_attributes' do
#     it 'includes car_id in ransackable attributes' do
#       expect(Variant.ransackable_attributes).to include('car_id')
#     end
#   end
# end



require 'rails_helper'

RSpec.describe Variant, type: :model do
  let!(:brand) { Brand.create!(name: 'Test Brand') } # Ensure a Brand model exists

  let!(:car) do
    Car.create!(
      name: 'Test Car',
      brand: brand,
      body_type: 'SUV', # Directly providing body type as a string
      car_types: 'New Car' # Directly providing car types as a string
    )
  end

  # Associations
  it { should belong_to(:car) }
  it { should have_many(:offers) }
  it { should have_many(:wishlists) }
  it { should have_many(:bookings) }
  it { should have_one(:feature) }
  it { should have_many(:reviews) }
  it { should have_many(:order_items) }

  # Validations
  it { should validate_presence_of(:variant) }
  it { should validate_uniqueness_of(:variant) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:colour) }

  describe 'associations' do
    it 'is valid with a car' do
      variant = Variant.new(
        variant: 'Test Variant',
        price: 100.0,
        quantity: 5,  # Adding a valid quantity
        colour: 'Red',  # Adding colour here
        car: car # Associate with a car
      )
      expect(variant).to be_valid
    end

    it 'is invalid without a car' do
      variant = Variant.new(
        variant: 'Test Variant',
        price: 100.0,
        quantity: 5,
        colour: 'Red'  # Adding colour here
      )
      expect(variant).not_to be_valid
      expect(variant.errors[:car]).to include("must exist") # Adjust error message if needed
    end
  end

  describe '#decrease_quantity' do
    let!(:variant) { Variant.create!(variant: 'Test Variant', price: 100.0, quantity: 5, colour: 'Red', car: car) }

    context 'when quantity is greater than 0' do
      it 'decreases the quantity by 1' do
        expect { variant.decrease_quantity }.to change { variant.reload.quantity }.by(-1)
      end

      it 'returns true' do
        expect(variant.decrease_quantity).to be_truthy
      end
    end

    context 'when quantity is 0' do
      before { variant.update(quantity: 0) }

      it 'does not change the quantity' do
        expect { variant.decrease_quantity }.not_to change { variant.reload.quantity }
      end

      it 'returns false' do
        expect(variant.decrease_quantity).to be_falsy
      end
    end
  end

  describe '#discounted_price' do
    let!(:variant) { Variant.create!(variant: 'Test Variant', price: 100.0, quantity: 5, colour: 'Red', car: car) }
    let!(:offer) { Offer.create!(variant: variant, discount: 20, start_date: Date.today - 1, end_date: Date.today + 1) }

    context 'when there is an active offer' do
      it 'calculates the discounted price' do
        expect(variant.discounted_price).to eq(80.0) # 100 - (20% of 100)
      end
    end

    context 'when there is no active offer' do
      before { offer.destroy }

      it 'returns the original price' do
        expect(variant.discounted_price).to eq(100.0)
      end
    end
  end

  describe '.ransackable_attributes' do
    it 'includes car_id in ransackable attributes' do
      expect(Variant.ransackable_attributes).to include('car_id')
    end
  end
end

