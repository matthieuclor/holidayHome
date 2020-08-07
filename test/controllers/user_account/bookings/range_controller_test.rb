# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Bookings
    class RangeControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:matthieu)
      end

      test "should render unauthorized status if not logged in" do
        get user_account_range_index_url, as: :json, params: {
          minDate: DateTime.now - 30.days,
          maxDate: DateTime.now + 30.days
        }

        assert_response :unauthorized
      end

      test "should render unprocessable entity without dates" do
        sign_in @user, scope: :user
        get user_account_range_index_url, as: :json
        assert_response :unprocessable_entity
      end

      test "should render range of bookings" do
        sign_in @user, scope: :user
        get user_account_range_index_url, xhr: true, params: {
          minDate: DateTime.now - 30.days,
          maxDate: DateTime.now + 30.days
        }

        current_venue = @controller.view_assigns["current_venue"]
        bookings = @controller.view_assigns["bookings"]

        assert_instance_of Venue, current_venue
        assert_instance_of BookingDecorator, bookings.first
        assert_response :success
      end
    end
  end
end
