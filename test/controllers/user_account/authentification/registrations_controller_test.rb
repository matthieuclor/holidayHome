# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Authentification
    class RegistrationsControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:matthieu), scope: :user
      end

      test "should get new" do
        sign_out :user
        get new_user_registration_url, xhr: true
        user = @controller.view_assigns["user"]

        assert user.new_record?
        assert_response :success
      end

      test "should create user" do
        sign_out :user
        post user_registration_url, params: {
          user: {
            first_name: 'Matthieu',
            last_name: 'Clor',
            email: 'matthieuclor2@gmail.com',
            password: '12345678',
            password_confirmation: '12345678'
          }
        }

        created_user = @controller.view_assigns["user"]
        authentification_mailer = AuthentificationMailer.confirmation_instructions(
          created_user,
          created_user.confirmation_token,
          {}
        )

        assert_emails(1) { authentification_mailer.deliver_later }
        assert_equal ['hello@hutoki.com'], authentification_mailer.from
        assert_equal [created_user.email], authentification_mailer.to
        assert_equal "Instructions de confirmation", authentification_mailer.subject
        assert_redirected_to user_account_dashboards_url
      end

      test "should get edit" do
        get edit_user_registration_url, xhr: true
        assert_response :success
      end

      test "should update user" do
        patch user_registration_url, params: {
          user: {
            first_name: 'Matthieu2',
            current_password: 'password01'
          }
        }

        assert_redirected_to root_url
      end

      test "should destroy user" do
        delete user_registration_url, xhr: true
        assert_response :success
      end
    end
  end
end
