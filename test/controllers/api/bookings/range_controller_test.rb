# frozen_string_literal: true

require 'test_helper'

module Api
  module Bookings
    class RangeControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:matthieu)
        @jwt_token = @user.generate_jwt
      end

      test 'should render unauthorized with wrong token' do
        get api_bookings_range_index_url,
            params: { year: Date.current.year },
            headers: { Authorization: 'bad_token_test' },
            as: :json

        assert_response :unauthorized
      end

      test 'should render current_venue with good token' do
        get api_bookings_range_index_url,
            params: { year: Date.current.year },
            headers: { Authorization: @jwt_token },
            as: :json

        bookings = @controller.view_assigns['bookings']
        current_venue = @controller.view_assigns['current_venue']
        current_user = @controller.view_assigns['current_user']

        assert_instance_of BookingDecorator, bookings.first
        assert_instance_of Venue, current_venue
        assert_instance_of User, current_user

        bookings.each do |booking|
          assert_equal booking.venue_id, current_venue.id
        end

        assert_response :success
      end

      test 'should render unprocessable_entity with wrong params' do
        get api_bookings_range_index_url,
            params: { month: Date.current.month },
            headers: { Authorization: @jwt_token },
            as: :json

        assert_response :unprocessable_entity
      end
    end
  end
end
