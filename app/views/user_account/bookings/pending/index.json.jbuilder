# frozen_string_literal: true

json.pending_bookings(
  @pending_bookings,
  :id,
  :human_date_range,
  :user_full_name,
  :progress_title
)
