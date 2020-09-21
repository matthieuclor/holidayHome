# frozen_string_literal: true

class CloseBookingJob < ApplicationJob
  queue_as :default

  def perform
    Booking.joins(:booking_approvals)
      .pending
      .where("now() >= deadline")
      .where(booking_approvals: { status: :refused })
      .distinct
      .each { |b| b.update_attribute(:status, :refused) }

    Booking.joins(:booking_approvals)
      .pending
      .where("now() >= deadline")
      .distinct
      .each { |b| b.update_attribute(:status, :accepted) }

    BookingApproval.joins(:booking)
      .pending
      .where(bookings: { status: %i(accepted refused) })
      .distinct
      .update_all(status: :out_of_time)
  end
end
