# frozen_string_literal: true

json.booking do
  json.call(@booking, :id, :status)
  json.status_fr Booking.human_attribute_name("status.#{@booking.status}")
end

json.booking_approvals @booking.booking_approvals do |approval|
  json.call(approval, :id, :user_id, :status)
  json.status_title BookingApproval.human_attribute_name("status.#{approval.status}")

  json.user_name(
    approval.user.present? &&
      "#{approval.user.first_name} #{approval.user.last_name}"
  )
end

if flash.present?
  json.flashes flash do |key, value|
    json.key key
    json.value value
  end

  flash.clear
end
