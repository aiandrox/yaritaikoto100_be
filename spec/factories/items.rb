# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    list
    sequence(:number)
    name { FFaker::Name.name }
    done_at { Time.zone.now }
  end
end
