FactoryBot.define do
  factory :subscription do
    started_at { Time.now }
    expires_at { 1.year.from_now }
    user
  end
end