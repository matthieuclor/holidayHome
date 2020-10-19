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

  test "default booking status must be pending" do
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

  test "send mail and notification if status change to accepted" do
    assert_enqueued_email_with BookingMailer, :send_status, args: @booking do
      assert_enqueued_jobs 1, only: NewNotificationJob do
        @booking.accepted!
      end
    end

    booking_mailer = BookingMailer.send_status(@booking)
    notification = Notification.unread.last

    assert_equal ['hello@hutoki.com'], booking_mailer.from
    assert_equal [@booking.user.email], booking_mailer.to
    assert_equal "Réservation Acceptée pour La Tania", booking_mailer.subject
    assert_equal notification.notification_type, "accepted_booking"
    assert_equal notification.user_id, @booking.user_id
    assert_equal notification.family, @booking.family

    @booking.booking_approvals.each do |approval|
      assert_not approval.pending?
    end
  end

  test "send mail and notification if status change to refused" do
    assert_enqueued_email_with BookingMailer, :send_status, args: @booking do
      assert_enqueued_jobs 1, only: NewNotificationJob do
        @booking.refused!
      end
    end

    booking_mailer = BookingMailer.send_status(@booking)
    notification = Notification.unread.last

    assert_equal ['hello@hutoki.com'], booking_mailer.from
    assert_equal [@booking.user.email], booking_mailer.to
    assert_equal "Réservation Refusée pour La Tania", booking_mailer.subject
    assert_equal notification.notification_type, "refused_booking"
    assert_equal notification.user_id, @booking.user_id
    assert_equal notification.family, @booking.family

    @booking.booking_approvals.each do |approval|
      assert_not approval.pending?
    end
  end

  test "not send mail if status change to canceled" do
    assert_no_enqueued_emails do
      assert_enqueued_jobs 0, only: NewNotificationJob do
        @booking.canceled!
      end
    end

    @booking.booking_approvals.each do |approval|
      assert_not approval.pending?
    end
  end

  test "not send mail if status change to pending" do
    assert_no_enqueued_emails do
      assert_enqueued_jobs 0, only: NewNotificationJob do
        @booking.pending!
      end
    end

    @booking.booking_approvals.each do |approval|
      assert_not approval.out_of_time?
    end
  end

  test "destroy bookings when venue destroyed" do
    venue = @booking.venue
    assert venue.destroy
    assert_empty Booking.where(venue_id: venue.id)
  end
end
