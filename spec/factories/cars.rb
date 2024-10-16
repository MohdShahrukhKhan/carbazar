# spec/factories/cars.rb
FactoryBot.define do
  factory :car do
    name { "Test Car" }
    brand
    body_type { "SUV" }
    car_types { "New Car" } 
    launch_date { Date.tomorrow }  # Ensure it's a future date
  end
end
