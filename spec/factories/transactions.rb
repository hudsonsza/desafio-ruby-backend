# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    shop { create(:shop) }
    transaction_type { rand(1..9) }
    card_number { Faker::Finance.credit_card }
    amount { rand(5000.0) }
    traded_at { Time.now }
  end
end
