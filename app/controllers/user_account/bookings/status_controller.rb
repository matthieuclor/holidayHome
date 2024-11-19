# frozen_string_literal: true

module UserAccount
  module Bookings
    class StatusController < UserAccount::ApplicationController
      respond_to :json

      def update
        @booking = Booking.includes(booking_approvals: [:user]).find(params[:id])

        if @booking.update(booking_params)
          flash[:success] = t('.success')
        else
          flash[:error] = t('.error')
        end
      end

      private

      def booking_params
        params.require(:booking).permit(:status)
      end
    end
  end
end
