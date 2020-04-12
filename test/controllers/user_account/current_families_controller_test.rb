require 'test_helper'

module UserAccount
  class CurrentFamiliesControllerTest < ActionDispatch::IntegrationTest
    test "should update current_family_id" do
      sign_in users(:matthieu), scope: :user
      patch user_account_current_families_url, params: { current_family: { id: 2 } }
      assert_equal users(:matthieu).current_family_id, 2
      assert_redirected_to user_account_dashboards_url
    end

    test "redirected if not logged in" do
      patch user_account_current_families_url, params: { current_family: { id: 2 } }
      assert_not_equal users(:matthieu).current_family_id, 2
      assert_redirected_to new_user_session_url
    end
  end
end
