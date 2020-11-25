# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class DashboardsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test 'redirected if not logged in' do
      sign_out @user
      get user_account_dashboards_url
      assert_redirected_to new_user_session_url
    end

    test 'should get index' do
      get user_account_dashboards_url
      assert_response :success
    end

    test 'should get index as json' do
      get user_account_dashboards_url, as: :json
      assert_response :success
    end
  end
end
