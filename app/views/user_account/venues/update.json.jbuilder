# frozen_string_literal: true

json.venue do
  json.call(@venue, :id)
end

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
