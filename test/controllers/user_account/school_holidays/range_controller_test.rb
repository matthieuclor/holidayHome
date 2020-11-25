# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module SchoolHolidays
    class RangeControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:matthieu)
      end

      test 'should render unauthorized status if not logged in' do
        get user_account_school_holidays_range_index_url, as: :json, params: {
          minDate: DateTime.now - 30.days,
          maxDate: DateTime.now + 30.days
        }

        assert_response :unauthorized
      end

      test 'should render unprocessable entity without dates' do
        sign_in @user, scope: :user
        get user_account_school_holidays_range_index_url, as: :json
        assert_response :unprocessable_entity
      end

      test 'should render range of school holidays' do
        sign_in @user, scope: :user
        get user_account_school_holidays_range_index_url, as: :json, params: {
          minDate: DateTime.now - 30.days,
          maxDate: DateTime.now + 30.days
        }

        school_holidays = @controller.view_assigns['school_holidays']

        school_holidays.each do |school_holiday|
          assert_instance_of SchoolHoliday, school_holiday
          assert_equal school_holiday.zone, 'Zone A'
        end

        assert_response :success
      end
    end
  end
end
