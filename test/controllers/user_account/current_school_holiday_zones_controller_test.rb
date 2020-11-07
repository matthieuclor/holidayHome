# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class CurrentSchoolHolidayZonesControllerTest < ActionDispatch::IntegrationTest
    test "should update current_school_holiday_zones" do
      @user = users(:matthieu)
      sign_in @user, scope: :user

      patch user_account_current_school_holiday_zones_url,
        as: :json,
        params: {
          zone: { key: "C", value: true }
        }

      assert_equal(
        @user.current_school_holiday_zones,
        {"A"=>"true", "B"=>"false", "C"=>"true"}
      )
      assert_response :success
    end

    test "redirected if not logged in" do
      patch user_account_current_school_holiday_zones_url,
        as: :json,
        params: {
          zone: { key: "C", value: true }
        }

      assert_not_equal(
        users(:matthieu).current_school_holiday_zones,
        {"A"=>"true", "B"=>"false", "C"=>"true"}
      )

      assert_response :unauthorized
    end
  end
end
