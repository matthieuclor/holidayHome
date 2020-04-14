# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Authentification
    class SessionsControllerTest < ActionDispatch::IntegrationTest
      test "should get new" do
        get new_user_session_url, xhr: true
        user = @controller.view_assigns["user"]

        assert user.new_record?
        assert_response :success
      end

      test "should sign in user" do
        post user_session_url, params: {
          user: {
            email: users(:matthieu).email,
            password: 'password01'
          }
        }

        assert_redirected_to user_account_dashboards_url
      end

      test "should sign out user" do
        delete destroy_user_session_url, xhr: true
        assert_response :success
      end
    end
  end
end
