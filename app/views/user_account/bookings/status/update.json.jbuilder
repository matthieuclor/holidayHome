json.booking do
  json.(@booking, :id, :status)
  json.status_fr Booking.human_attribute_name("status.#{@booking.status}")
end

json.booking_approvals @booking.booking_approvals do |approval|
  json.(approval, :id, :user_id, :status)
  json.status_title BookingApproval.human_attribute_name("status.#{approval.status}")

  json.user_name user_name = if approval.user.present?
    "#{approval.user.first_name} #{approval.user.last_name}"
  else
    nil
  end
end

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end

