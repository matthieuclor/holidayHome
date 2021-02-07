# frozen_string_literal: true

require 'test_helper'

module Api
  class VenuesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      @jwt_token = @user.generate_jwt
    end

    test 'should render unauthorized with wrong token' do
      get api_venues_url, headers: { Authorization: 'bad_token_test' }, as: :json

      assert_response :unauthorized
    end

    test 'should render unauthorized with expired token' do
      @expired_jwt_token = JWT.encode(
        { id: @user.id, exp: 1.day.ago.to_i },
        Rails.application.secrets.secret_key_base
      )

      get api_venues_url, headers: { Authorization: @expired_jwt_token }, as: :json

      assert_response :unauthorized
    end

    test 'should render venues with good token' do
      get api_venues_url, headers: { Authorization: @jwt_token }, as: :json

      venues = @controller.view_assigns['venues']
      current_user = @controller.view_assigns['current_user']

      assert_instance_of VenueDecorator, venues.first
      assert_instance_of User, current_user

      venues.each do |venue|
        assert_equal venue.family_id, @user.current_family_id
      end

      assert_response :success
    end
  end
end
