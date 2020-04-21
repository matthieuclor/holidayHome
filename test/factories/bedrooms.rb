# frozen_string_literal: true

FactoryBot.define do
  factory :bedroom do
    name { Faker::Movies::StarWars.planet }
  end
end
