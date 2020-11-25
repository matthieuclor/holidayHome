# frozen_string_literal: true

json.messages @messages do |message|
  json.call(message, :id, :user_id)
  json.content simple_format(message.content)
  json.created_at "Le #{l(message.created_at, format: :medium)}"
  json.user_name "#{message.user.first_name} #{message.user.last_name}"
  json.approval_status message.booking_approval&.status

  if message.booking_approval.present?
    json.approval_status_title BookingApproval.human_attribute_name(
      "status.#{message.booking_approval.status}"
    )
  else
    json.approval_status_title nil
  end
end

json.message_pagy do
  json.call(@pagy, :next)
end
