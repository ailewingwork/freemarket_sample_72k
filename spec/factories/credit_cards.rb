FactoryBot.define do
  factory :credit_card do
    user_id { nil }
    customer_id { 1 }
    card_id { 1 }
  end
end
