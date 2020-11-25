# frozen_string_literal: true

require 'test_helper'

module UserAccount
  class BookingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:matthieu)
      sign_in @user, scope: :user
    end

    test 'redirected if not logged in' do
      sign_out @user
      get user_account_bookings_url
      assert_response :redirect
    end

    test 'should render paginate bookings' do
      get user_account_bookings_url

      bookings = @controller.view_assigns['bookings']
      pagy = @controller.view_assigns['pagy']

      assert_instance_of BookingDecorator, bookings.first
      assert_instance_of Pagy, pagy
      assert_equal bookings.first.user, @user
      assert_response :success
    end

    test 'should render booking with html' do
      get user_account_booking_url(bookings(:la_tania_booking))

      booking = @controller.view_assigns['booking']

      assert_instance_of Booking, booking
      assert_equal booking.user, @user
      assert_response :success
    end

    test 'should render booking with json' do
      get user_account_booking_url(bookings(:la_tania_booking)), as: :json

      booking = @controller.view_assigns['booking']

      assert_instance_of BookingDecorator, booking
      assert_equal booking.user, @user
      assert_response :success
    end

    test 'should create booking' do
      post user_account_bookings_url,
           as: :json,
           params: {
             booking: {
               from: DateTime.now + 30.days,
               to: DateTime.now + 40.days,
               messages_attributes: [{ content: "C'est pour une réservation" }]
             }
           }

      assert_response :created
    end
  end
end
