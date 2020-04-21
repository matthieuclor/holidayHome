# frozen_string_literal: true

FactoryBot.define do
  factory :network do
    name { Faker::Movies::StarWars.specie }
    connection_type { Network.connection_types.keys.sample }
    network_name { Faker::Movies::StarWars.droid }
    password { Faker::Internet.password }
  end
end
