# frozen_string_literal: true

class UpdateBookingCurrentUsersJob < ApplicationJob
  queue_as :default

  def perform(booking)
    ActionCable.server.broadcast(
      "booking_channel_#{booking.id}",
      currentUsers: booking.current_users
    )
  end
end
