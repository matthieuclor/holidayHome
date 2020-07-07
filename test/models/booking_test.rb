# frozen_string_literal: true

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  def setup
    @booking = bookings(:la_tania_booking)
  end

  test "valid booking" do
    assert @booking.valid?
  end

  %i(from to user venue).each do |attibute|
    test "invalid booking without #{attibute}" do
      @booking.send("#{attibute}=", nil)
      assert_not @booking.valid?
      assert_not_nil @booking.errors[attibute]
    end
  end

  test "default booking status must is pending" do
    booking = create(:booking, { user: @booking.user, venue: @booking.venue })
    assert booking.pending?
  end

  test "set deadline before create" do
    booking = create(:booking, { user: @booking.user, venue: @booking.venue })
    assert booking.deadline = DateTime.now + booking.family.days_for_approval.days
  end

  test "set booking approvals after create" do
    booking = create(:booking, { user: @booking.user, venue: @booking.venue })
    assert_not_empty booking.booking_approvals
    assert_equal booking.booking_approvals.count, 2
    assert_equal booking.booking_approvals.first.user, users(:olivia)
  end

  test "send mail if status change to accepted" do
    @booking.accepted!
    booking_mailer = BookingMailer.send_status(@booking)
    assert_emails(1) { booking_mailer.deliver_later }
    assert_equal ['hello@hutoki.com'], booking_mailer.from
    assert_equal [@booking.user.email], booking_mailer.to
    assert_equal "Réservation Acceptée pour La Tania", booking_mailer.subject
  end

  test "send mail if status change to refused" do
    @booking.refused!
    booking_mailer = BookingMailer.send_status(@booking)
    assert_emails(1) { booking_mailer.deliver_later }
    assert_equal ['hello@hutoki.com'], booking_mailer.from
    assert_equal [@booking.user.email], booking_mailer.to
    assert_equal "Réservation Refusée pour La Tania", booking_mailer.subject
  end

  test "send mail if status change to canceled" do
    @booking.canceled!
    booking_mailer = BookingMailer.send_status(@booking)
    assert_emails(1) { booking_mailer.deliver_later }
    assert_equal ['hello@hutoki.com'], booking_mailer.from
    assert_equal [@booking.user.email], booking_mailer.to
    assert_equal "Réservation Annulée pour La Tania", booking_mailer.subject
  end

  test "destroy bookings when venue destroyed" do
    venue = @booking.venue
    assert venue.destroy
    assert_empty Booking.where(venue_id: venue.id)
  end
end
