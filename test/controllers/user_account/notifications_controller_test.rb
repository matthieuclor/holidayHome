# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class NotificationsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test 'redirected if not logged in' do
      sign_out @user
      get user_account_notifications_url
      assert_response :redirect
    end

    test 'should render paginate notifications' do
      get user_account_notifications_url

      notifications = @controller.view_assigns['notifications']
      pagy = @controller.view_assigns['pagy']

      assert_instance_of Notification, notifications.first
      assert_instance_of Pagy, pagy
      assert_equal notifications.first.user, @user
      assert_response :success
    end
  end
end
