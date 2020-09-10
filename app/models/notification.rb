# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :family

  default_scope { order(:created_at).reverse_order }

  enum status: %i(unread readed)

  validates :user, :family, :title, :description, :url, :status, presence: true
  validates :status, inclusion: { in: statuses.keys }
end

