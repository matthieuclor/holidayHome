# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :family

  default_scope { order(:created_at).reverse_order }

  enum notification_type: %i(new_message)
  enum status: %i(unread readed)

  validates :user,
            :family,
            :notification_type,
            :description,
            :url,
            :status,
            presence: true

  validates :status, inclusion: { in: statuses.keys }
  validates :notification_type, inclusion: { in: notification_types.keys }

  after_create -> { NewNotificationJob.perform_later(self.id) }
end

