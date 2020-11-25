# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class MessagesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @booking = bookings(:la_tania_booking)
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test 'should unauthorized if not logged in' do
      sign_out @user
      get user_account_booking_messages_url(@booking), as: :json
      assert_response :unauthorized
    end

    test 'should render messages as json' do
      get user_account_booking_messages_url(@booking), as: :json

      messages = @controller.view_assigns['messages']

      assert_instance_of Message, messages.first
      assert_response :success
    end

    test 'should create message with notification' do
      assert_enqueued_jobs 2, only: [NewMessageJob, NewNotificationJob] do
        post user_account_booking_messages_url(@booking),
             params: { message: { content: 'Nouveau message' } },
             as: :json
      end

      message = @controller.view_assigns['message']
      notification = Notification.unread.last

      assert_instance_of Message, message
      assert_equal message.booking, @booking
      assert_equal notification.notification_type, 'new_message'
      assert_equal notification.user_id, @booking.user_id
      assert_equal notification.family, @booking.family
      assert_response :created
    end

    test 'should create message without notification because an existing one' do
      Notification.first.unread!

      post user_account_booking_messages_url(@booking),
           params: { message: { content: 'Nouveau message' } },
           as: :json

      assert_equal Notification.unread.count, 1
    end

    test 'should create message without notification because the user is on the booking page' do
      @booking.update(current_users: ['1'])

      post user_account_booking_messages_url(@booking),
           params: { message: { content: 'Nouveau message' } },
           as: :json

      assert_equal Notification.unread.count, 0
    end
  end
end
