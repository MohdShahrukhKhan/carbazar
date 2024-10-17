FactoryBot.define do
  factory :message do
    chat_id { 1 }
    sender_id { 1 }
    content { "MyText" }
  end
end
