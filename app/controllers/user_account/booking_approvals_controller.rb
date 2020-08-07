# frozen_string_literal: true

module UserAccount
  class BookingApprovalsController < UserAccount::ApplicationController
    respond_to(:js)
    before_action :set_booking, :set_booking_approval

    def edit
      @booking_approval.assign_attributes(booking_approval_params)
      @booking_approval.build_message
    end

    def update
      @booking_approval.assign_attributes(booking_approval_params)
      @booking_approval.message.user = current_user
      @booking_approval.message.booking = @booking

      if @booking_approval.save
        flash[:success] = "La réservation a bien été mise à jour"
        render :update, status: :ok
      else
        flash[:error] = "Un problem est survenu lors de la mise à jour de la réservation"
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def set_booking_approval
      @booking_approval = BookingApproval.find(params[:id])
    end

    def booking_approval_params
      params.require(:booking_approval).permit(:status, message_attributes: :content)
    end
  end
end
