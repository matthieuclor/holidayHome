# frozen_string_literal: true

module AdminAccount
  module Bookings
    class BookingApprovalsController < AdminAccount::ApplicationController
      before_action :set_booking_approval

      def edit
      end

      def update
        if @booking_approval.update(booking_approval_params)
          flash[:success] = "L'approbation a bien été mise à jour"
          render js: 'location.reload()'
        else
          flash[:error] = "Un problem est survenu lors de la mise à jour de l'approbation"
          render :edit
        end
      end

      private

      def set_booking_approval
        @booking_approval = BookingApproval.find_by(
          booking_id: params[:booking_id],
          id: params[:id]
        )
      end

      def booking_approval_params
        params.require(:booking_approval).permit(:user_id, :status)
      end
    end
  end
end
