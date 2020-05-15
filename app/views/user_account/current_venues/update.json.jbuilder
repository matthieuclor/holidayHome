json.current_venue_id current_user.current_venue_id

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
