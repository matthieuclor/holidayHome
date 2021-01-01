# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    vehicle_type { Faker::Vehicle.manufacture }
    name { Faker::Vehicle.make_and_model }
    size { Vehicle.sizes.keys.sample }
    condition { Vehicle.conditions.keys.sample }
    comment { Faker::Vehicle.standard_specs }
  end
end
