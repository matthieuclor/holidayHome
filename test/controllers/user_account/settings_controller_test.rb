# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class SettingsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      sign_in users(:matthieu), scope: :user
      get user_account_settings_url
      assert_response :success
    end

    test 'redirected if not logged in' do
      get user_account_settings_url
      assert_redirected_to new_user_session_url
    end
  end
end
