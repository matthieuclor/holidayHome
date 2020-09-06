# frozen_string_literal: true

class UpdateBookingApprovalJob < ApplicationJob
  queue_as :default

  def perform(booking_approval)
    ActionCable.server.broadcast(
      "booking_channel_#{booking_approval.booking_id}",
      bookingApproval: render_booking_approval(booking_approval)
    )
  end

  private

  def render_booking_approval(booking_approval)
    UserAccount::BookingApprovalsController.render(
      file: 'user_account/booking_approvals/show.json',
      locals: { booking_approval: booking_approval }
    )
  end
end
