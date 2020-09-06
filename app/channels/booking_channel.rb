class BookingChannel < ApplicationCable::Channel
  def subscribed
    booking = Booking.find(params[:booking_id])
    current_users = booking.current_users << current_user.id
    stream_from "booking_channel_#{booking.id}"
    booking.update_column(:current_users, current_users.uniq)
    UpdateBookingCurrentUsersJob.perform_later(booking)
  end

  def unsubscribed
    booking = Booking.find(params[:booking_id])
    booking.current_users.delete(current_user.id.to_s)
    booking.update_column(:current_users, booking.current_users.uniq)
    UpdateBookingCurrentUsersJob.perform_later(booking)
  end
end
