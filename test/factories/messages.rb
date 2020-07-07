# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { Faker::Movies::StarWars.quote }
  end
end
