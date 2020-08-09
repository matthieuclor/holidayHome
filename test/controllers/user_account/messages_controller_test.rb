# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class MessagesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @booking = bookings(:la_tania_booking)
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test "should unauthorized if not logged in" do
      sign_out @user
      get user_account_booking_messages_url(@booking), as: :json
      assert_response :unauthorized
    end

    test "should render messages as json" do
      get user_account_booking_messages_url(@booking), as: :json

      messages = @controller.view_assigns["messages"]

      assert_instance_of Message, messages.first
      assert_response :success
    end

    test "should create message" do
      post user_account_booking_messages_url(@booking),
        params: { message: { content: "Nouveau message" } },
        as: :json

      message = @controller.view_assigns["message"]

      assert_instance_of Message, message
      assert_equal message.booking, @booking
      assert_response :created
    end
  end
end
