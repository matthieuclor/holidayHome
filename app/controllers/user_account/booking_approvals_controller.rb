# frozen_string_literal: true

module UserAccount
  class BookingApprovalsController < UserAccount::ApplicationController
    respond_to(:js)
    before_action :set_booking, :set_booking_approval

    def edit
      puts "****************"
      @booking_approval.status = params[:status]
      puts "****************"
    end

    def update
    end

    private

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def set_booking_approval
      @booking_approval = BookingApproval.find_by(booking: @booking, user: current_user)
    end

    def booking_approval_params
      params.require(:booking_approval).permit(:status, :message)
    end
  end
end
