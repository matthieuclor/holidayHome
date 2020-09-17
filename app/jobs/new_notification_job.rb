# frozen_string_literal: true

class NewNotificationJob < ApplicationJob
  queue_as :default

  def perform(id)
    notification = Notification.find(id)
    notifications = Notification.where(user_id: notification.user_id).unread

    ActionCable.server.broadcast(
      "notifiaction_channel_#{notification.user_id}",
      {
        notifications: render_notifications(notifications),
        flashes: render_flashes({ notice: notification.description })
      }
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

  def render_flashes(flashes)
    UserAccount::NotificationsController.render(
      partial: 'shared/flash_messages',
      locals: { flash: flashes },
      layout: false
    )
  end
end
