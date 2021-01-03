# frozen_string_literal: true

json.vehicle_types @vehicle_types do |vehicle_type|
  json.name vehicle_type.name
  json.icon_class "#{vehicle_type.icon_prefix} #{vehicle_type.icon_class}"
end
