# frozen_string_literal: true

json.venue(@venue, :id, :name)

json.vehicles @vehicles do |vehicle|
  json.call(
    vehicle,
    :id,
    :vehicle_type,
    :name,
    :size,
    :condition,
    :comment
  )
end
