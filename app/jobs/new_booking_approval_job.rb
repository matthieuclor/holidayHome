# frozen_string_literal: true

class NewBookingApprovalJob < ApplicationJob
  queue_as :default

  def perform(booking_approval)
    Notification.create(
      url: Rails.application.routes.url_helpers.user_account_booking_path(booking_approval.booking),
      user: booking_approval.user,
      family: booking_approval.booking.family,
      notification_type: :new_booking,
      description: Notification.human_attribute_name(
        "description.new_booking",
        {
          sender_name: UserDecorator.new(booking_approval.booking.user).full_name,
          venue: booking_approval.booking.venue.name,
          dates: BookingDecorator.new(booking_approval.booking).human_date_range
        }
      )
    )
  end
end
