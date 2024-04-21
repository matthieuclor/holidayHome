# frozen_string_literal: true

module UserAccount
  class BookingApprovalsController < UserAccount::ApplicationController
    respond_to :json

    def update
      @booking = Booking.find(params[:booking_id])
      @booking_approval = BookingApproval.find(params[:id])
      @booking_approval.assign_attributes(booking_approval_params)
      @booking_approval.message.user = current_user
      @booking_approval.message.booking = @booking

      if @booking_approval.save
        NewMessageJob.perform_later(@booking_approval.message)
        UpdateBookingApprovalJob.perform_later(@booking_approval)

        @booking.current_users.include?(@booking.user_id.to_s) || create_notification

        flash[:success] = t('.success')
        render :update, status: :ok
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def booking_approval_params
      params.require(:booking_approval).permit(:status, message_attributes: :content)
    end

    def create_notification
      @booking = BookingDecorator.new(@booking)

      Notification.create(
        url: user_account_booking_path(@booking),
        user: @booking.user,
        family: @booking.family,
        notification_type: :new_message,
        description: Notification.human_attribute_name(
          'description.new_message',
          { venue: @booking.venue.name, dates: @booking.human_date_range }
        )
      )
    end
  end
end
