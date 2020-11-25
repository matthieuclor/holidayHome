# frozen_string_literal: true

json.booking do
  json.call(@booking, :id, :user_id, :status, :deadline, :created_at)
  json.status_fr Booking.human_attribute_name("status.#{@booking.status}")
  json.date_range @booking.human_date_range
  json.user_name "#{@booking.user.first_name} #{@booking.user.last_name}"
  json.venue_name @booking.venue.name
  json.progress_percentage @booking.progress_percentage
  json.progress_title @booking.progress_title

  if @booking.venue.photos.attached?
    json.venue_photo_url url_for(
      @booking.venue.photos.first.variant(resize_to_limit: [300, 200])
    )
  end
end

json.booking_approvals @booking.booking_approvals do |approval|
  json.call(approval, :id, :user_id, :status)
  json.status_title BookingApproval.human_attribute_name("status.#{approval.status}")
  json.user_name(
    approval.user.present? &&
      "#{approval.user.first_name} #{approval.user.last_name}"
  )
end
