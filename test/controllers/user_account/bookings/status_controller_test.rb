# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Bookings
    class StatusControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:matthieu)
      end

      test 'should render unauthorized status if not logged in' do
        put user_account_status_url(bookings(:la_tania_booking)),
            as: :json,
            params: { booking: { status: 'canceled' } }

        assert_response :unauthorized
      end

      test 'should update status' do
        sign_in @user, scope: :user

        put user_account_status_url(bookings(:la_tania_booking)),
            as: :json,
            params: { booking: { status: 'canceled' } }

        booking = @controller.view_assigns['booking']

        assert_instance_of Booking, booking
        assert_equal booking.user, @user
        assert_equal booking.status, 'canceled'
        assert_response :success
      end
    end
  end
end
