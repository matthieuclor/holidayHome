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
        post user_unlock_url, params: { user: { email: users(:user_locked).email } }
        authentification_mailer = AuthentificationMailer.unlock_instructions(
          users(:user_locked),
          users(:user_locked).unlock_token,
          {}
        )

        assert_emails(1) { authentification_mailer.deliver_later }
        assert_equal ['hello@hutoki.com'], authentification_mailer.from
        assert_equal [users(:user_locked).email], authentification_mailer.to
        assert_equal "Instructions pour déverrouiller le compte", authentification_mailer.subject
        assert_redirected_to new_user_session_url
      end

      test "should unlock user account" do
        get user_unlock_url(unlock_token: users(:user_locked).unlock_token)
        assert_response :success
      end
    end
  end
end
