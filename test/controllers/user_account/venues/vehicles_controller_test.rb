# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Venues
    class VehiclesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @venue = venues(:la_tania)
        sign_in users(:matthieu), scope: :user
      end

      test 'redirected if not logged in' do
        sign_out :user
        get user_account_venue_vehicles_url(@venue), as: :json
        assert_response :unauthorized
      end

      test 'should get index as json' do
        get user_account_venue_vehicles_url(@venue), as: :json
        venue = @controller.view_assigns['venue']
        vehicles = @controller.view_assigns['vehicles']

        assert_instance_of Venue, venue
        assert_instance_of Vehicle, vehicles.first
        assert_response :success
      end

      test 'should get new as json' do
        get new_user_account_venue_vehicle_url(@venue), as: :json
        venue = @controller.view_assigns['venue']
        vehicle = @controller.view_assigns['vehicle']

        assert_instance_of Venue, venue
        assert_instance_of Vehicle, vehicle
        assert vehicle.new_record?
        assert_response :success
      end

      test 'should create as json' do
        post user_account_venue_vehicles_url(@venue), params: { vehicle: {
          venue_id: @venue.id,
          vehicle_type: 'Vélo',
          name: 'Vélo rouge',
          size: 'standard',
          condition: 'good',
          comment: 'Voici un commentaire'
        } }, as: :json

        venue = @controller.view_assigns['venue']
        assert_instance_of Venue, venue
        assert_response :success
      end

      test 'should get edit as json' do
        get edit_user_account_venue_vehicle_url(@venue, vehicles(:la_tania_bicycle)), as: :json
        venue = @controller.view_assigns['venue']
        vehicle = @controller.view_assigns['vehicle']

        assert_instance_of Venue, venue
        assert_instance_of Vehicle, vehicle
        assert_response :success
      end

      test 'should update the vehicle as json' do
        patch user_account_venue_vehicle_url(
          @venue, vehicles(:la_tania_bicycle)
        ), params: { vehicle: { name: 'Vélo vert' } }, as: :json

        venue = @controller.view_assigns['venue']
        vehicle = @controller.view_assigns['vehicle']

        assert_instance_of Venue, venue
        assert_instance_of Vehicle, vehicle
        assert_response :success
      end

      test 'should destroy the vehicle as json' do
        delete user_account_venue_vehicle_url(@venue, vehicles(:la_tania_bicycle)), as: :json
        venue = @controller.view_assigns['venue']
        vehicle = @controller.view_assigns['vehicle']

        assert_instance_of Venue, venue
        assert_instance_of Vehicle, vehicle
        assert_response :success
      end
    end
  end
end
