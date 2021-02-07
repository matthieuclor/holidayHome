# frozen_string_literal: true

require 'test_helper'

module Api
  class FamiliesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      @jwt_token = @user.generate_jwt
    end

    test 'should render unauthorized with wrong token' do
      get api_families_url, headers: { Authorization: 'bad_token_test' }, as: :json

      assert_response :unauthorized
    end

    test 'should render families with good token' do
      get api_families_url, headers: { Authorization: @jwt_token }, as: :json

      families = @controller.view_assigns['families']
      current_user = @controller.view_assigns['current_user']

      assert_instance_of Family, families.first
      assert_instance_of User, current_user

      families.each do |family|
        assert family.family_links.pluck(:user_id).include?(@user.id)
      end

      assert_response :success
    end
  end
end
