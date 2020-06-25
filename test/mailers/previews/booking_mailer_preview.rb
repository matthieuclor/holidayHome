# frozen_string_literal: true

class BookingMailerPreview < ActionMailer::Preview
  def send_approval
    BookingMailer.send_approval(Booking.first, User.first)
  end

  def send_status
    BookingMailer.send_status(Booking.first)
  end
end
