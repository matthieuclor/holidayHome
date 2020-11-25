# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class UsersControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:matthieu), scope: :user
    end

    test 'should by redirected if not logged in' do
      sign_out :user
      get user_account_users_url
      assert_redirected_to new_user_session_url
    end

    test 'should get index' do
      get user_account_users_url

      users = @controller.view_assigns['users']
      pagy = @controller.view_assigns['pagy']

      assert_instance_of UserDecorator, users.first
      assert_instance_of Pagy, pagy
      assert_response :success
    end

    test 'should get show' do
      get user_account_user_url(users(:olivia)), xhr: true
      user = @controller.view_assigns['user']
      assert_instance_of UserDecorator, user
      assert_response :success
    end

    test 'should by unauthorized if user is not part of your family' do
      get user_account_user_url(users(:pierre)), xhr: true
      assert_response :unauthorized
    end
  end
end
