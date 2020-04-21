# frozen_string_literal: true

FactoryBot.define do
  factory :bathroom do
    name { Faker::Movies::Hobbit.location }
  end
end
