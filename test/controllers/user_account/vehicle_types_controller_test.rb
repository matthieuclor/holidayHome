# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class VehicleTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:matthieu), scope: :user
    end

    test 'redirected if not logged in' do
      sign_out :user
      get user_account_vehicle_types_url, as: :json
      assert_response :unauthorized
    end

    test 'should get index' do
      get user_account_vehicle_types_url, as: :json
      vehicle_types = @controller.view_assigns['vehicle_types']
      assert_instance_of VehicleType, vehicle_types.first
      assert_response :success
    end
  end
end
