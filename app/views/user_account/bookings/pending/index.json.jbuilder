json.pending_bookings @pending_bookings do |booking|
  json.id booking.id
  json.from l(booking.from, format: :medium)
  json.to l(booking.to, format: :medium)
  json.created_at l(booking.created_at, format: :medium)
  json.days_left distance_of_time_in_words(DateTime.now, booking.deadline)
  json.venue_name booking.venue.name
  json.user_name "#{booking.user.first_name} #{booking.user.last_name}"
end
