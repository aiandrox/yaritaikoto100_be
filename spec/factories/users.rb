# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_digest { 'MyString' }
  end
end
