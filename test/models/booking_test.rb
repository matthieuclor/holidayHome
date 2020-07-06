# frozen_string_literal: true

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  test "should save booking with all attributes" do
    booking = build(:booking_with_dependencies)
    assert booking.save
  end

  %i(from to user venue).each do |attibute|
    test "should not save booking without #{attibute}" do
      booking = build(:booking_with_dependencies)
      booking.send("#{attibute}=", nil)
      assert_not booking.save
    end
  end

  test "should set deadline before validation" do
    booking = create(:booking_with_dependencies)
    assert booking.deadline = DateTime.now + booking.family.days_for_approval.days
  end

  test "should set booking approvals after create" do
    booking = build(:booking_with_dependencies)
    user = create(:user_with_families)
    booking.family.users << user
    booking.save

    assert booking.booking_approvals.present?
    assert booking.booking_approvals.first.user == user
  end
end
