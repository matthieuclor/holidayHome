# frozen_string_literal: true

class Message < ApplicationRecord
  CONTENT_MAX = 500

  belongs_to :user
  belongs_to :booking

  has_one :booking_approval, dependent: :nullify

  default_scope { order(:created_at).reverse_order }

  validates :content, presence: true
  validates :content, length: { minimum: 2, maximum: CONTENT_MAX }
end
