# frozen_string_literal: true

json.vehicle do
  json.call(
    @vehicle,
    :id,
    :venue_id,
    :vehicle_type,
    :name,
    :size,
    :condition,
    :comment
  )

  json.venue_name @venue.name

  json.errors(@vehicle.errors.messages.transform_keys { |k| k.to_s.camelize(:lower) })
  json.sizes_collection(Vehicle.sizes.keys.map do |size|
    [Vehicle.human_attribute_name("size.#{size}"), size]
  end)
  json.conditions_collection(Vehicle.conditions.keys.map do |condition|
    [Vehicle.human_attribute_name("condition.#{condition}"), condition]
  end)
end

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
