# frozen_string_literal: true

module UserAccount
  module Bookings
    class YearlyController < UserAccount::ApplicationController
      respond_to :json
      include CurrentVenue
      before_action :set_current_venue

      def index
        from = Date.parse(params["minDate"])
        to = Date.parse(params["maxDate"])

        @bookings = BookingDecorator.wrap(
          @current_venue
            .bookings
            .where(status: %i(pending accepted))
            .where(from: from..to)
            .or(@current_venue.bookings.where(to: from..to))
        )
      end
    end
  end
end
