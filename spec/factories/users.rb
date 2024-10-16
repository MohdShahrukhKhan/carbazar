FactoryBot.define do
  factory :user do
    name { "Abhishek" }  # String values should be enclosed in quotes
    email { "abhishek@gmail.com" }  # Email should be a string
    password { "password@123" }  # Password should be a string
    stripe_customer_id {nil}  # You can assign a default value or leave it empty
  end
end



