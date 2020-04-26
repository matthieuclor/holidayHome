# frozen_string_literal: true

FactoryBot.define do
  factory :network do
    name { Faker::Movies::StarWars.droid }
    password { Faker::Internet.password }
  end
end
