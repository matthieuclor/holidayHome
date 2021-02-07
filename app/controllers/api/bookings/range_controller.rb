# frozen_string_literal: true

module Api
  module Bookings
    class RangeController < Api::ApplicationController
      include CurrentVenue
      before_action :set_current_venue

      def index
        return head :unprocessable_entity unless params['year'].present?

        from = DateTime.new(params['year'].to_i).beginning_of_year
        to = DateTime.new(params['year'].to_i).end_of_year

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

        render status: :ok
      end
    end
  end
end
