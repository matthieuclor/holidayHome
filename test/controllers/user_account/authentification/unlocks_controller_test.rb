# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Authentification
    class UnlocksControllerTest < ActionDispatch::IntegrationTest
      test "should get new" do
        get new_user_unlock_url
        user = @controller.view_assigns["user"]

        assert user.new_record?
        assert_response :success
      end

      test "should send unlock email" do
        post user_unlock_url, params: { user: { email: users(:locked_user).email } }
        authentification_mailer = AuthentificationMailer.unlock_instructions(
          users(:locked_user),
          users(:locked_user).unlock_token,
          {}
        )

        assert_emails(1)
        assert_equal ['hello@hutoki.com'], authentification_mailer.from
        assert_equal [users(:locked_user).email], authentification_mailer.to
        assert_equal "Instructions pour déverrouiller le compte", authentification_mailer.subject
        assert_redirected_to new_user_session_url
      end

      test "should unlock user account" do
        get user_unlock_url(unlock_token: users(:locked_user).unlock_token)
        assert_response :success
      end
    end
  end
end
