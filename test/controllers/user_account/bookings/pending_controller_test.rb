# frozen_string_literal: true

require 'test_helper'

module UserAccount
  module Bookings
    class RangeControllerTest < ActionDispatch::IntegrationTest
      test 'should render pending bookings' do
        sign_in users(:matthieu), scope: :user

        get user_account_pending_index_url, as: :json

        current_family = @controller.view_assigns['current_family']
        current_venue = @controller.view_assigns['current_venue']
        pending_bookings = @controller.view_assigns['pending_bookings']

        assert_instance_of Family, current_family
        assert_instance_of Venue, current_venue
        assert_instance_of BookingDecorator, pending_bookings.first
        pending_bookings.each(&:pending?)
        assert_response :success
      end

      test 'redirected if not logged in' do
        get user_account_pending_index_url, as: :json
        assert_response :unauthorized
      end
    end
  end
end
