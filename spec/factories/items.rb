# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    list
    sequence(:number)
    name { Faker::Name.name }
    done_at { nil }

    trait :done do
      done_at { Time.zone.now }
    end
  end
end
