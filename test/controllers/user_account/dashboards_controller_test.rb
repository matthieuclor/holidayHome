require 'test_helper'

module UserAccount
  class DashboardsControllerTest < ActionDispatch::IntegrationTest
    test "should get index" do
      sign_in users(:matthieu), scope: :user
      get user_account_dashboards_url
      assert_response :success
    end

    test "redirected if not logged in" do
      get user_account_dashboards_url
      assert_redirected_to new_user_session_url
    end
  end
end
