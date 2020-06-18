# frozen_string_literal: true

class BookingMailerPreview < ActionMailer::Preview
  def send_approval
    BookingMailer.send_approval(Booking.first, User.first)
  end
end
