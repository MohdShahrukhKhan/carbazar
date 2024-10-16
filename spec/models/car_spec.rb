# require 'rails_helper'

# RSpec.describe Car, type: :model do
#   let(:brand) { Brand.create!(name: 'Test Brand') }

#   describe 'associations' do
#     it { should belong_to(:brand) }
#     it { should have_many(:review) }
#     it { should have_many(:variants).dependent(:destroy) }
#     it { should accept_nested_attributes_for(:variants).allow_destroy(true) }
#   end

#   describe 'validations' do
#     it { should validate_presence_of(:name) }
#     it { should validate_presence_of(:brand_id) }
#     it { should validate_presence_of(:body_type) }
#     it { should validate_presence_of(:car_types) }

#     it 'validates body type inclusion' do
#       valid_car = Car.new(name: 'Test Car', body_type: 'SUV', car_types: 'New Car', brand: brand)
#       expect(valid_car).to be_valid

#       invalid_car = Car.new(name: 'Test Car', body_type: 'Bike', car_types: 'New Car', brand: brand)
#       expect(invalid_car).not_to be_valid
#       expect(invalid_car.errors[:body_type]).to include("Bike is not a valid body type")
#     end

#     it 'validates car type inclusion' do
#       valid_car = Car.new(name: 'Test Car', body_type: 'SUV', car_types: 'New Car', brand: brand)
#       expect(valid_car).to be_valid

#       invalid_car = Car.new(name: 'Test Car', body_type: 'SUV', car_types: 'Old Car', brand: brand)
#       expect(invalid_car).not_to be_valid
#       expect(invalid_car.errors[:car_types]).to include("Old Car is not a valid car type")
#     end

#     it 'validates launch_date is not in the past' do
#       future_car = Car.new(name: 'Future Car', body_type: 'SUV', car_types: 'New Car', brand: brand, launch_date: Date.today + 1)
#       expect(future_car).to be_valid

#       past_car = Car.new(name: 'Past Car', body_type: 'SUV', car_types: 'New Car', brand: brand, launch_date: Date.today - 1)
#       expect(past_car).not_to be_valid
#       expect(past_car.errors[:launch_date]).to include("can't be in the past")
#     end
#   end

#   # describe 'scopes' do
#   #   let!(:car1) { Car.create!(name: 'Car1', body_type: 'SUV', car_types: 'New Car', brand: brand) }
#   #   let!(:car2) { Car.create!(name: 'Car2', body_type: 'Sedan', car_types: 'Upcoming Car', brand: brand) }

  

#     context '.by_body_type' do
#       it 'returns cars by body type' do
#         expect(Car.by_body_type('SUV')).to include(car1)
#         expect(Car.by_body_type('SUV')).not_to include(car2)
#       end
#     end

    

#     context '.new_cars' do
#       it 'returns only new cars' do
#         expect(Car.new_cars).to include(car1)
#         expect(Car.new_cars).not_to include(car2)
#       end
#     end

#     context '.upcoming_cars' do
#       it 'returns only upcoming cars' do
#         expect(Car.upcoming_cars).to include(car2)
#         expect(Car.upcoming_cars).not_to include(car1)
#       end
#     end
#   end

#   describe 'ransack search' do
#     it 'includes brand_id in ransackable attributes' do
#       expect(Car.ransackable_attributes).to include('brand_id')
#     end
#   end
# end




require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:brand) { Brand.create!(name: 'Test Brand') }

  describe 'associations' do
    it { should belong_to(:brand) }
    it { should have_many(:review) }
    it { should have_many(:variants).dependent(:destroy) }
    it { should accept_nested_attributes_for(:variants).allow_destroy(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:brand_id) }
    it { should validate_presence_of(:body_type) }
    it { should validate_presence_of(:car_types) }

    it 'validates body type inclusion' do
      valid_car = Car.new(name: 'Test Car', body_type: 'SUV', car_types: 'New Car', brand: brand)
      expect(valid_car).to be_valid

      invalid_car = Car.new(name: 'Test Car', body_type: 'Bike', car_types: 'New Car', brand: brand)
      expect(invalid_car).not_to be_valid
      expect(invalid_car.errors[:body_type]).to include("Bike is not a valid body type")
    end

    it 'validates car type inclusion' do
      valid_car = Car.new(name: 'Test Car', body_type: 'SUV', car_types: 'New Car', brand: brand)
      expect(valid_car).to be_valid

      invalid_car = Car.new(name: 'Test Car', body_type: 'SUV', car_types: 'Old Car', brand: brand)
      expect(invalid_car).not_to be_valid
      expect(invalid_car.errors[:car_types]).to include("Old Car is not a valid car type")
    end

    it 'validates launch_date is not in the past' do
      future_car = Car.new(name: 'Future Car', body_type: 'SUV', car_types: 'New Car', brand: brand, launch_date: Date.today + 1)
      expect(future_car).to be_valid

      past_car = Car.new(name: 'Past Car', body_type: 'SUV', car_types: 'New Car', brand: brand, launch_date: Date.today - 1)
      expect(past_car).not_to be_valid
      expect(past_car.errors[:launch_date]).to include("can't be in the past")
    end
  end

  # describe 'scopes' do
  #   let!(:car1) { Car.create!(name: 'Car1', body_type: 'SUV', car_types: 'New Car', brand: brand) }
  #   let!(:car2) { Car.create!(name: 'Car2', body_type: 'Sedan', car_types: 'Upcoming Car', brand: brand) }

  #   context '.by_body_type' do
  #     it 'returns cars by body type' do
  #       expect(Car.by_body_type('SUV')).to include(car1)
  #       expect(Car.by_body_type('SUV')).not_to include(car2)
  #     end
  #   end

  #   context '.new_cars' do
  #     it 'returns only new cars' do
  #       expect(Car.new_cars).to include(car1)
  #       expect(Car.new_cars).not_to include(car2)
  #     end
  #   end

  #   context '.upcoming_cars' do
  #     it 'returns only upcoming cars' do
  #       expect(Car.upcoming_cars).to include(car2)
  #       expect(Car.upcoming_cars).not_to include(car1)
  #     end
  #   end
  # end

  describe 'ransack search' do
    it 'includes brand_id in ransackable attributes' do
      expect(Car.ransackable_attributes).to include('brand_id')
    end
  end
end

