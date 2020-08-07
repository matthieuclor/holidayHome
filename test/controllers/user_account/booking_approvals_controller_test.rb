# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class BookingApprovalsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
      @booking = bookings(:la_tania_booking)
      @booking_approval = booking_approvals(:la_tania_booking_approval_from_matthieu)
    end

    test "redirected if not logged in" do
      sign_out @user

      get edit_user_account_booking_booking_approval_url(@booking, @booking_approval),
        xhr: true,
        params: {
          booking_approval: { status: "accepted" }
        }

      assert_response :redirect
    end

    test "should render accepted edit page" do
      get edit_user_account_booking_booking_approval_url(@booking, @booking_approval),
        xhr: true,
        params: {
          booking_approval: { status: "accepted" }
        }

      booking_approval = @controller.view_assigns["booking_approval"]
      assert booking_approval.accepted?
      assert booking_approval.message.present?
      assert booking_approval.message.new_record?
      assert_response :success
    end

    test "should render refused edit page" do
      get edit_user_account_booking_booking_approval_url(@booking, @booking_approval),
        xhr: true,
        params: {
          booking_approval: { status: "refused" }
        }

      booking_approval = @controller.view_assigns["booking_approval"]
      assert booking_approval.refused?
      assert booking_approval.message.present?
      assert booking_approval.message.new_record?
      assert_response :success
    end

    test "should accepted approval and create message" do
      put user_account_booking_booking_approval_url(@booking, @booking_approval),
        xhr: true,
        params: {
          booking_approval: {
            status: "accepted",
            message_attributes: { content: "Ok pour moi !" }
          }
        }

      booking_approval = @controller.view_assigns["booking_approval"]
      assert booking_approval.accepted?
      assert_equal booking_approval.message.user, @user
      assert_equal booking_approval.message.booking, @booking
      assert_equal booking_approval.message.content, "Ok pour moi !"
      assert_response :success
    end

    test "should refused approval and create message" do
      put user_account_booking_booking_approval_url(@booking, @booking_approval),
        xhr: true,
        params: {
          booking_approval: {
            status: "refused",
            message_attributes: { content: "No way !" }
          }
        }

      booking_approval = @controller.view_assigns["booking_approval"]
      assert booking_approval.refused?
      assert_equal booking_approval.message.user, @user
      assert_equal booking_approval.message.booking, @booking
      assert_equal booking_approval.message.content, "No way !"
      assert_response :success
    end
  end
end
