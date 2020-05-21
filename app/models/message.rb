# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :booking_approval
  belongs_to :booking

  validates :user, :booking_approval, :booking, :content, presence: true
end
