# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  has_one :family, through: :venue

  has_many :booking_approvals, dependent: :destroy
  has_many :messages, dependent: :destroy

  enum status: %i(pending accepted refused)

  validates :from, :to, :user, :venue, :deadline, presence: true
  validates :status, inclusion: { in: statuses.keys }

  before_validation :set_deadline, on: :create

  after_create :set_booking_approvals

  private

  def set_deadline
    self.deadline = DateTime.now + self.family.days_for_approval.days
  end

  def set_booking_approvals
    if self.family.days_for_approval.zero?
      self.accepted!
    else
      self.family.users.each do |user|
        next if self.user_id == user.id
        BookingApproval.create(booking: self, user: user)
      end
    end
  end
end
