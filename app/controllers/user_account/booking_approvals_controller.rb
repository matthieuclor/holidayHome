# frozen_string_literal: true

module UserAccount
  class BookingApprovalsController < UserAccount::ApplicationController
    respond_to(:json)

    def update
      @booking = Booking.find(params[:booking_id])
      @booking_approval = BookingApproval.find(params[:id])
      @booking_approval.assign_attributes(booking_approval_params)
      @booking_approval.message.user = current_user
      @booking_approval.message.booking = @booking

      if @booking_approval.save
        NewMessageJob.perform_later(@booking_approval.message)
        UpdateBookingApprovalJob.perform_later(@booking_approval)

        flash[:success] = "La réservation a bien été mise à jour"
        render :update, status: :ok
      else
        flash[:error] = "Un problem est survenu lors de la mise à jour de la réservation"
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def booking_approval_params
      params.require(:booking_approval).permit(:status, message_attributes: :content)
    end
  end
end
