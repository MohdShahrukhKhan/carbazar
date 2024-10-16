
FactoryBot.define do
  factory :booking do
    user
    variant
    status { 0 }
    booking_date { DateTime.now }
  end
end
