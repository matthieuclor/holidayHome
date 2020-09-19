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
  validates_uniqueness_of :url, conditions: -> { where(status: :unread) }

  after_create -> { NewNotificationJob.perform_later(self.id) }
end

