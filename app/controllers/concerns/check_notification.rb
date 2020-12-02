# frozen_string_literal: true

module CheckNotification
  extend ActiveSupport::Concern

  included do
    def check_notification
      Rails.env.test? && Bullet.enable = false

      notifications = Notification.where(
        url: request.path.chomp('.json'),
        user_id: current_user.id
      )

      return unless notifications.present?

      notifications.each { |notif| notif.readed! if notif.unread? }

      return if current_user.current_family_id == notifications.first.family_id

      current_user.update(current_family_id: notifications.first.family_id)
    ensure
      Rails.env.test? && Bullet.enable = true
    end
  end
end
