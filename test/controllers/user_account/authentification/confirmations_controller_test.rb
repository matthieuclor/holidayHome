# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Authentification
    class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
      test "should get new" do
        get new_user_confirmation_url, xhr: true
        user = @controller.view_assigns["user"]

        assert_instance_of User, user
        assert user.new_record?
        assert_response :success
      end

      test "should create confirmation" do
        post user_confirmation_url, params: { user: { email: users(:matthieu).email } }, xhr: true
        authentification_mailer = AuthentificationMailer.confirmation_instructions(
          users(:matthieu),
          users(:matthieu).confirmation_token,
          {}
        )

        assert_equal ['hello@hutoki.com'], authentification_mailer.from
        assert_equal [users(:matthieu).email], authentification_mailer.to
        assert_equal "Instructions de confirmation", authentification_mailer.subject
        assert_response :success
      end

      test "should confirm user" do
        get user_confirmation_url(users(:matthieu).confirmation_token)
        assert_not_nil users(:matthieu).confirmed_at
        assert_response :success
      end
    end
  end
end
