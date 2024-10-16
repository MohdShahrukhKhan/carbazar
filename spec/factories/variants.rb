# FactoryBot.define do
#   factory :variant do
#     variant { "Variant 1" }
#     price { "10000" }
#     colour { "Red" }
#     association :car   # This ensures that a Car is automatically created
#   end
# end

# spec/factories/variants.rb
FactoryBot.define do
  factory :variant do
    sequence(:variant) { |n| "Variant #{n}" } # Ensures unique variant names
    price { 30000 }
    colour { "Blue" }
    association :car
  end
end

