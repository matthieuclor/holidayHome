# frozen_string_literal: true

require 'test_helper'

module Api
  class CurrentVenuesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      @jwt_token = @user.generate_jwt
    end

    test 'should render unauthorized with wrong token' do
      put api_current_venues_url,
          params: { current_venue: { id: 2 } },
          headers: { Authorization: 'bad_token_test' },
          as: :json

      assert_response :unauthorized
    end

    test 'should render current_venue with good token' do
      put api_current_venues_url,
          params: { current_venue: { id: 2 } },
          headers: { Authorization: @jwt_token },
          as: :json

      current_venue = @controller.view_assigns['current_venue']
      current_user = @controller.view_assigns['current_user']

      assert_instance_of Venue, current_venue
      assert_instance_of User, current_user
      assert_equal current_venue.family_id, @user.current_family_id
      assert_equal current_venue.id.to_s,
                   @user.reload.current_venue_id[@user.current_family_id.to_s]

      assert_response :success
    end
  end
end
