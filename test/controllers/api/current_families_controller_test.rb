# frozen_string_literal: true

require 'test_helper'

module Api
  class CurrentFamiliesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      @jwt_token = @user.generate_jwt
    end

    test 'should render unauthorized with wrong token' do
      put api_current_families_url,
          params: { current_family: { id: 4 } },
          headers: { Authorization: 'bad_token_test' },
          as: :json

      assert_response :unauthorized
    end

    test 'should render current_venue with good token' do
      put api_current_families_url,
          params: { current_family: { id: 4 } },
          headers: { Authorization: @jwt_token },
          as: :json

      current_family = @controller.view_assigns['current_family']
      current_user = @controller.view_assigns['current_user']

      assert_instance_of Family, current_family
      assert_instance_of User, current_user
      assert_equal current_user.current_family_id, 4

      assert_response :success
    end
  end
end
