# frozen_string_literal: true

module UserAccount
  class MessagesController < UserAccount::ApplicationController
    respond_to :json
    before_action :set_booking

    def index
      @pagy, @messages = pagy(
        @booking.messages.includes(:booking_approval, :user)
      )
    end

    def create
      @message = @booking.messages.build(
        message_params.merge({ user: current_user })
      )

      if @message.save
        booking = Booking.find(@message.booking_id)
        NewMessageJob.perform_later(@message)

        booking.current_users.include?(booking.user_id.to_s) || create_notification(booking)

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

    def create_notification(booking)
      booking = BookingDecorator.new(booking)

      Notification.create(
        url: user_account_booking_path(booking),
        user: booking.user,
        family: booking.family,
        notification_type: :new_message,
        description: Notification.human_attribute_name(
          'description.new_message',
          { venue: booking.venue.name, dates: booking.human_date_range }
        )
      )
    end
  end
end
