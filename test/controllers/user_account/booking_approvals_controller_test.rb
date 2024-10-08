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

    test 'redirected if not logged in' do
      sign_out @user

      put user_account_booking_booking_approval_url(@booking, @booking_approval),
          as: :json,
          params: {
            booking_approval: {
              status: 'accepted',
              message_attributes: { content: 'Ok pour moi !' }
            }
          }

      assert_response :unauthorized
    end

    test 'should accepted approval and create message' do
      assert_enqueued_jobs 1, only: NewNotificationJob do
        put user_account_booking_booking_approval_url(@booking, @booking_approval),
            as: :json,
            params: {
              booking_approval: {
                status: 'accepted',
                message_attributes: { content: 'Ok pour moi !' }
              }
            }
      end

      booking_approval = @controller.view_assigns['booking_approval']
      notification = Notification.unread.last

      assert booking_approval.accepted?
      assert_equal booking_approval.message.user, @user
      assert_equal booking_approval.message.booking, @booking
      assert_equal booking_approval.message.content, 'Ok pour moi !'
      assert_equal notification.notification_type, 'new_message'
      assert_equal notification.user_id, @booking.user_id
      assert_equal notification.family, @booking.family
      assert_response :success
    end

    test 'should refused approval and create message' do
      assert_enqueued_jobs 1, only: NewNotificationJob do
        put user_account_booking_booking_approval_url(@booking, @booking_approval),
            as: :json,
            params: {
              booking_approval: {
                status: 'refused',
                message_attributes: { content: 'No way !' }
              }
            }
      end

      booking_approval = @controller.view_assigns['booking_approval']
      notification = Notification.unread.last

      assert booking_approval.refused?
      assert_equal booking_approval.message.user, @user
      assert_equal booking_approval.message.booking, @booking
      assert_equal booking_approval.message.content, 'No way !'
      assert_equal notification.notification_type, 'new_message'
      assert_equal notification.user_id, @booking.user_id
      assert_equal notification.family, @booking.family
      assert_response :success
    end
  end
end
