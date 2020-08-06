# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Bookings
    class RangeControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:matthieu), scope: :user
      end

      test "should render unprocessable entity without dates" do
        get user_account_monthly_index_url, xhr: true

        assert_response :unprocessable_entity
      end

      test "should render range of bookings" do
        get user_account_monthly_index_url, xhr: true, params: {
          minDate: '2019-08-01+00:00:00',
          maxDate: '2020-07-31+23:59:59'
        }

        assert_response :success
      end
    end
  end
end
