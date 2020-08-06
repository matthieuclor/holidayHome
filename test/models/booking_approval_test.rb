# frozen_string_literal: true

require 'test_helper'

class BookingApprovalTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  def setup
    @booking_approval = booking_approvals(:la_tania_booking_approval)
  end

  test "valid booking approval" do
    assert @booking_approval.valid?
  end

  %i(booking user status).each do |attibute|
    test "should not save booking approval without #{attibute}" do
      @booking_approval.send("#{attibute}=", nil)
      assert_not @booking_approval.valid?
      assert_not_nil @booking_approval.errors[attibute]
    end
  end

  test "invalid booking approval with duplicate user on booking" do
    booking_approval = build(:booking_approval, {
      user: @booking_approval.user,
      booking: @booking_approval.booking
    })

    assert_not booking_approval.valid?
    assert_not_nil booking_approval.errors[:user]
  end

  test "send mail to family users after create" do
    booking = create(:booking, {
      user: @booking_approval.booking.user,
      venue: @booking_approval.booking.venue
    })

    assert_enqueued_emails(booking.booking_approvals.size)

    booking.booking_approvals.each do |booking_approval|
      booking_mailer = BookingMailer.send_approval(booking, booking_approval.user)
      assert_equal ['hello@hutoki.com'], booking_mailer.from
      assert_equal [booking_approval.user.email], booking_mailer.to
      assert_equal "Demande de réservation pour La Tania", booking_mailer.subject
    end
  end

  test "destroy booking approval when booking destroyed" do
    booking = @booking_approval.booking
    assert booking.destroy
    assert_empty BookingApproval.where(booking_id: booking.id)
  end
end
