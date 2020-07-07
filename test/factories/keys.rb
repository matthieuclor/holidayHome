# frozen_string_literal: true

FactoryBot.define do
  factory :key do
    name { Faker::House.room }
  end
end
