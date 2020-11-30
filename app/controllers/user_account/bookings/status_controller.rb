# frozen_string_literal: true

module UserAccount
  module Bookings
    class StatusController < UserAccount::ApplicationController
      respond_to :json

      def update
        @booking = Booking.includes(booking_approvals: [:user]).find(params[:id])

        if @booking.update(booking_params)
          flash[:success] = 'La réservation a bien été mise à jour'
        else
          flash[:error] = 'Un problem est survenu lors de la mise à jour de la réservation'
        end
      end

      private

      def booking_params
        params.require(:booking).permit(:status)
      end
    end
  end
end
