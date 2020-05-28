class NewBookingMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "booking_channel_#{message.booking_id}",
      message: render_message(message)
    )
  end

  private

  def render_message(message)
    UserAccount::Bookings::MessagesController.render(
      partial: 'message',
      locals: { message: message }
    )
  end
end
