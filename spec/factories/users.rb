# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.city }
    email { Faker::Internet.email }
    password { Faker::Number.number(6) }
  end
end
