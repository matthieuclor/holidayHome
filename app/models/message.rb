# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  default_scope { order(:created_at).reverse_order }

  enum status: %i(unread read)

  validates :user, :booking, :content, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :content, length: { minimum: 2, maximum: 1000 }

  after_create { NewBookingMessageJob.perform_later(self) }
end
