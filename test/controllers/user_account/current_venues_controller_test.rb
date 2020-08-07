# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class CurrentVenuesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
    end

    test "should update current_venue_id" do
      sign_in @user, scope: :user
      patch user_account_current_venues_url, as: :json, params: { current_venue: { id: 2 } }
      assert_equal @user.current_venue_id, {"1"=>"2"}
      assert_response :success
    end

    test "redirected if not logged in" do
      patch user_account_current_venues_url, as: :json, params: { current_venue: { id: 2 } }
      assert_not_equal @user.current_venue_id, {"1"=>"2"}
      assert_response :unauthorized
    end
  end
end
