require 'test_helper'

module UserAccount
  module Authentification
    module Registrations
      class StatusesControllerTest < ActionDispatch::IntegrationTest
        setup do
          @user = users(:matthieu)
          sign_in @user, scope: :user
        end

        test "should deactivate user and cancel bookings" do
          delete user_account_statuses_url

          assert @user.deactivated?
          @user.bookings.each { |booking| assert_not booking.pending? }
          @user.bookings.where('bookings.from >= ?', Date.current).each do |booking|
            assert booking.canceled?
          end

          assert_redirected_to root_url
        end
      end
    end
  end
end
