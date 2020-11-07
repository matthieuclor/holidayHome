json.current_school_holiday_zones current_user.current_school_holiday_zones

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
