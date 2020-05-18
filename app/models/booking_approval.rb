# frozen_string_literal: true

class BookingApproval < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  enum status: %i(pending accepted refused out_of_time)

  validates :booking, :user, :status, presence: true
  validates :status, inclusion: { in: statuses.keys }
end
