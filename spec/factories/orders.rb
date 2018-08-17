# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    product_id { Faker::Number.number(10) }
    cart_id { Faker::Number.number(10) }
    quantity { Faker::Number.number(10) }
  end
end
