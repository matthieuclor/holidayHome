# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  enum status: %i(unread read)

  validates :user, :booking, :content, presence: true
  validates :status, inclusion: { in: statuses.keys }
end
