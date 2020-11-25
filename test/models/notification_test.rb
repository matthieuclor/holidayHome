# frozen_string_literal: true

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def setup
    @notification = notifications(:notification_new_message_from_la_tania_booking)
  end

  test 'valid notification' do
    assert @notification.valid?
  end

  %i(user family notification_type description url status).each do |attibute|
    test "invalid notification without #{attibute}" do
      @notification.send("#{attibute}=", nil)
      assert_not @notification.valid?
      assert_not_nil @notification.errors[attibute]
    end
  end

  test 'default notification status must be unread' do
    notification = create(
      :notification,
      {
        notification_type: :new_message,
        description: 'Vous avez un nouveau message',
        url: '/user_account/bookings/2',
        user: @notification.user,
        family: @notification.family
      }
    )

    assert notification.unread?
  end

  test 'should launch job after create' do
    assert_enqueued_jobs 1, only: NewNotificationJob do
      create(
        :notification,
        {
          notification_type: :new_message,
          description: 'Vous avez un nouveau message',
          url: '/user_account/bookings/3',
          user: @notification.user,
          family: @notification.family
        }
      )
    end
  end
end
