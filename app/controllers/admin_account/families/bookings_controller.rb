# frozen_string_literal: true

module AdminAccount
  module Families
    class BookingsController < AdminAccount::ApplicationController
      respond_to :js

      def index
        @query = Booking.joins(:user).where(venues: { family_id: params[:family_id] }).ransack(bookings_ransack_params)
        @pagy, @bookings = pagy(
          @query.result.includes(:venue, :user)
        )
        @bookings = BookingDecorator.wrap(@bookings)
      end

      private

      def bookings_ransack_params
        @bookings_ransack_params ||= params[:q]&.permit(
          :user_id_eq,
          :venue_id_eq,
          :status_eq,
          :from_gteq,
          :to_lteq
        )
      end
    end
  end
end
