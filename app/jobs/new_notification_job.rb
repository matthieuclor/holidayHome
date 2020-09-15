# frozen_string_literal: true

class NewNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    ActionCable.server.broadcast(
      "notifiaction_channel_#{user_id}",
      render_notifications(Notification.where(user_id: user_id).unread)
    )
  end

  private

  def render_notifications(notifications)
    UserAccount::NotificationsController.render(
      partial: 'user_account/layouts/notifications',
      locals: { notifications: notifications },
      layout: false
    )
  end
end
