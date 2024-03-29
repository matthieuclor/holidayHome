# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :family

  default_scope { order(:created_at).reverse_order }

  enum status: %i(unread readed)
  enum notification_type: %i(
    new_message
    new_invitation
    accepted_invitation
    refused_invitation
    new_booking
    accepted_booking
    refused_booking
  )

  validates :notification_type,
            :description,
            :url,
            :status,
            presence: true

  validates :status, inclusion: { in: statuses.keys }
  validates :notification_type, inclusion: { in: notification_types.keys }
  validates :description, uniqueness: {
    scope: :user,
    conditions: -> { where(status: :unread) }
  }

  after_create_commit -> { NewNotificationJob.perform_later(id) }
end
