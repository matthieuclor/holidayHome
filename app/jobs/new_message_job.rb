# frozen_string_literal: true

class NewMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "booking_channel_#{message.booking_id}",
      message: render_message(message)
    )
  end

  private

  def render_message(message)
    UserAccount::MessagesController.render(
      template: 'user_account/messages/show.json',
      locals: { message: message }
    )
  end
end
