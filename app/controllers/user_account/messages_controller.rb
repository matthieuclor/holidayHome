# frozen_string_literal: true

module UserAccount
  class MessagesController < UserAccount::ApplicationController
    respond_to(:json)
    before_action :set_booking

    def index
      @messages = @booking.messages.includes(:booking_approval, :user)
    end

    def create
      @message = @booking.messages.build(
        message_params.merge({ user: current_user })
      )

      if @message.save
        NewMessageJob.perform_later(@message)
        render :create, status: :created
      else
        render :create, status: :unprocessable_entity
      end
    end

    private

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def message_params
      params.require(:message).permit(:content)
    end
  end
end
