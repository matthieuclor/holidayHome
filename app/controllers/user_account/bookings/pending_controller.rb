# frozen_string_literal: true

module UserAccount
  module Bookings
    class PendingController < UserAccount::ApplicationController
      respond_to :json
      include CurrentFamily, CurrentVenue
      before_action :set_current_family, :set_current_venue

      def index
        @pending_bookings = @current_family
          .bookings
          .joins(:booking_approvals, :user)
          .where(status: :pending)
          .where(venue: @current_venue)
          .where(booking_approvals: { user: current_user, status: :pending })
      end
    end
  end
end
