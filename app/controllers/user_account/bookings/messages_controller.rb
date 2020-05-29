# frozen_string_literal: true

module UserAccount
  module Bookings
    class MessagesController < UserAccount::ApplicationController
      respond_to :js
      before_action :set_booking

      def index
        @messages = @booking.messages.includes(user: [:avatar_attachment])
        @message = @booking.messages.build
      end

      def create
        @message = @booking.messages.build(
          message_params.merge({ user: current_user })
        )

        if @message.save
          head :created
        else
          render(
            json: { error: @message.errors.full_messages.first },
            status: :unprocessable_entity
          )
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
end
