# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle_type do
    name { Faker::Vehicle.manufacture }
    icon_prefix { VehicleType.icon_prefixes.keys.sample }
    icon_class { 'fa-test' }
  end
end
