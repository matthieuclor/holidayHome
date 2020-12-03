# frozen_string_literal: true

module CheckNotification
  extend ActiveSupport::Concern

  included do
    def check_notification
      notifications = Notification.where(
        url: request.path.chomp('.json'),
        user_id: current_user.id,
        status: :unread
      )

      notifications.update_all(status: :readed) if notifications.present?
    end
  end
end
