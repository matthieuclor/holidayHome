# frozen_string_literal: true

require 'test_helper'

module Api
  module Authentification
    class SessionsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:matthieu)
      end

      test 'should sign in user' do
        post api_sessions_url, params: {
          user: {
            email: @user.email,
            password: 'password01'
          }
        }, as: :json

        user = @controller.view_assigns['user']
        jwt_token = @controller.view_assigns['jwt_token']
        jwt_payload = JWT.decode(jwt_token, Rails.application.secret_key_base).first

        assert_instance_of User, user
        assert_equal user.id, @user.id
        assert_equal user.id, jwt_payload['id']
        assert_response :success
      end

      test 'should not sign in with wrong password' do
        post api_sessions_url, params: {
          user: {
            email: @user.email,
            password: 'testtest'
          }
        }, as: :json

        assert_response :unauthorized
      end

      test 'should not sign in blocked user' do
        post api_sessions_url, params: {
          user: {
            email: users(:blocked_user).email,
            password: 'password07'
          }
        }, as: :json

        assert_response :unauthorized
      end
    end
  end
end
