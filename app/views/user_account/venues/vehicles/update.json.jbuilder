# frozen_string_literal: true

json.vehicle(@vehicle, :id, :venue_id)

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
