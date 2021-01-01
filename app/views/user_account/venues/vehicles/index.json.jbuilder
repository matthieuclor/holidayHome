# frozen_string_literal: true

json.venue(@venue, :id, :name)

json.vehicles @vehicles do |vehicle|
  json.call(
    vehicle,
    :id,
    :venue_id,
    :vehicle_type,
    :name,
    :size,
    :condition,
    :comment
  )
  json.size_fr Vehicle.human_attribute_name("size.#{vehicle.size}")
  json.condition_fr Vehicle.human_attribute_name("condition.#{vehicle.condition}")
  json.condition_badge_class Vehicle.human_attribute_name("condition_badge_class.#{vehicle.condition}")
end
