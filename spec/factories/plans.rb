# spec/factories/plans.rb
FactoryBot.define do
  factory :plan do
    name { "Basic Plan" } # Set a default name
    details { "This is a basic plan." }
    plan_type { :free }
    months { 12 }
    price_monthly { nil }
    price_yearly { nil }
    limit { 10 }
    limit_type { 0 }
    discount { false }
    discount_type { nil }
    discount_percentage { nil }
    benefits { "Basic benefits included." }
    coming_soon { false }
    active { true }
    available { true }
    stripe_price_id { "stripe_price_123" }

    trait :paid do
      plan_type { :paid }
      price_monthly { 100.00 }
      price_yearly { 1200.00 }
      discount { true }
      discount_type { "Percentage" }
      discount_percentage { 10 }
      benefits { "Paid benefits included." }
    end

    trait :free do
      plan_type { :free }
      # No price_monthly or price_yearly for free plan
    end
  end
end
