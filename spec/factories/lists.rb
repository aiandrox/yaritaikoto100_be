# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    user
    uuid { SecureRandom.urlsafe_base64 }
    sequence(:title) { |n| "リスト #{n}" }
    published { Faker::Boolean.boolean }
  end
end
