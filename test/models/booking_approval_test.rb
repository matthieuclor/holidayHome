# frozen_string_literal: true

require 'test_helper'

class BookingApprovalTest < ActiveSupport::TestCase
  test "should save booking approval with all attributes" do
    booking_approval = build(:booking_approval)
    assert booking_approval.save
  end

  %i(booking user status).each do |attibute|
    test "should not save booking approval without #{attibute}" do
      booking_approval = build(:booking_approval, { attibute => nil })
      assert_not booking_approval.save
    end
  end
end
