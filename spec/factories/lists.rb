# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    user
    uuid { SecureRandom.uuid }
    published { Faker::Boolean.boolean }
  end
end
