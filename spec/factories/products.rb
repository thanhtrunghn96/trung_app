# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { Faker::Number.number(10) }
    content { Faker::Lorem.characters(55) }
    image_link { File.open(Rails.root.join('public/uploads/trung.png')) }
  end
end
