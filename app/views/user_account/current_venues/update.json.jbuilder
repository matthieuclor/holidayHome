# frozen_string_literal: true

json.current_venue(@current_venue, :id, :name)

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
