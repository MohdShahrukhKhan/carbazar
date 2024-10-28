# # FactoryBot.define do
# #   factory :variant do
# #     variant { "Variant 1" }
# #     price { "10000" }
# #     colour { "Red" }
# #     association :car   # This ensures that a Car is automatically created
# #   end
# # end

# spec/factories/variants.rb
FactoryBot.define do
  factory :variant do
    sequence(:variant) { |n| "Variant #{n}" } # Ensures unique variant names
    price { 30000 }
    colour { "Blue" }
    association :car
  end
end



# spec/factories/variants.rb
# spec/factories/variants.rb
# FactoryBot.define do
#   factory :variant do
#     association :user, factory: :user, strategy: :build

#     # Add necessary attributes if your model requires them for validation
#     launch_date { Date.today unless new_car? }

#     trait :new_car do
#       after(:build) { |variant| variant.new_car = true }
#     end

#     # Ensure the name attribute is optional or remove it if not needed
#     # sequence(:name) { |n| "Variant #{n}" }
#   end
# end
