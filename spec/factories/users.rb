# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    uid { rand(100_000..999_999) }
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
