# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    email { Faker::Internet.email }
  end
end
