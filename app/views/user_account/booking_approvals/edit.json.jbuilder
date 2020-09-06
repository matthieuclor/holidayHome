json.booking_approval do
  json.errors @booking_approval.errors.messages
end

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
