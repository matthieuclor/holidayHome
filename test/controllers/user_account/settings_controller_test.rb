require 'test_helper'

module UserAccount
  class SettingsControllerTest < ActionDispatch::IntegrationTest
    test "redirected if not logged in" do
      get user_account_settings_url
      assert_redirected_to new_user_session_url
    end
  end
end
