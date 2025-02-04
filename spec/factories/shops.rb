# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    name { Faker::Name.name }
    owner_name { Faker::Name.name }
  end
end
