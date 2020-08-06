# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Authentification
    class PasswordsControllerTest < ActionDispatch::IntegrationTest
      test "should get new" do
        get new_user_password_url
        user = @controller.view_assigns["user"]

        assert_instance_of User, user
        assert user.new_record?
        assert_response :success
      end

      test "should create reset_password" do
        post user_password_url, params: { user: { email: users(:matthieu).email } }
        authentification_mailer = AuthentificationMailer.reset_password_instructions(
          users(:matthieu),
          users(:matthieu).reset_password_token,
          {}
        )

        assert_emails(1)
        assert_equal ['hello@hutoki.com'], authentification_mailer.from
        assert_equal [users(:matthieu).email], authentification_mailer.to
        assert_equal "Instructions pour changer le mot de passe", authentification_mailer.subject
        assert_redirected_to new_user_session_url
      end

      test "should get edit" do
        get edit_user_password_url(reset_password_token: users(:matthieu).reset_password_token)
        assert_response :success
      end

      test "should update password" do
        patch user_password_url, params: {
          user: {
            reset_password_token: users(:matthieu).reset_password_token,
            password: "12345678",
            password_confirmation: "12345678"
          }
        }

        assert_response :success
      end
    end
  end
end
