# spec/factories/comments.rb
FactoryBot.define do
  factory :comment do
    text { "This is a comment." }
    association :review
    association :user # Assuming user association is required
  end
end
