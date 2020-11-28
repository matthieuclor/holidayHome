json.call(booking_approval, :id, :user_id, :status)
json.status_title BookingApproval.human_attribute_name("status.#{booking_approval.status}")
json.user_name "#{booking_approval.user.first_name} #{booking_approval.user.last_name}"
