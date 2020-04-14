# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class SettingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:matthieu), scope: :user
    end

    test "redirected if not logged in" do
      sign_out :user
      get user_account_settings_url
      assert_redirected_to new_user_session_url
    end

    test "should get index" do
      get user_account_settings_url
      assert_response :success
    end
  end
end
