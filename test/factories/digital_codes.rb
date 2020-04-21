# frozen_string_literal: true

FactoryBot.define do
  factory :digital_code do
    name { Faker::House.room }
    password { Faker::Internet.password }
  end
end
