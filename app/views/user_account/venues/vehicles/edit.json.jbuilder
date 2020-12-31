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
end

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
