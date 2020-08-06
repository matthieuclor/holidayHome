namespace :bookings do
  desc "Close finished bookings"
  task close: :environment do
    Booking.joins(:booking_approvals).pending
      .where("now() >= deadline")
      .where(booking_approvals: { status: :refused })
      .update_all(status: :refused)

    Booking.joins(:booking_approvals).pending
      .where("now() >= deadline")
      .update_all(status: :accepted)
  end
end
