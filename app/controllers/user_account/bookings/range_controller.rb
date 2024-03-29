# frozen_string_literal: true

module UserAccount
  module Bookings
    class RangeController < UserAccount::ApplicationController
      include CurrentVenue
      respond_to :json
      before_action :set_current_venue

      def index
        begin
          from = Date.parse(params['minDate'])
          to = Date.parse(params['maxDate'])
        rescue TypeError
          head :unprocessable_entity
        end

        @bookings = BookingDecorator.wrap(
          @current_venue
            .bookings
            .joins(:user)
            .where(status: %i(pending accepted))
            .where(from: from..to)
            .or(
              @current_venue
                .bookings
                .joins(:user)
                .where(status: %i(pending accepted))
                .where(to: from..to)
            )
        )
      end
    end
  end
end
