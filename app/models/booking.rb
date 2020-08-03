# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  has_one :family, through: :venue

  has_many :booking_approvals, dependent: :destroy
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :messages

  enum status: %i(pending accepted refused canceled)

  validates :from, :to, :user, :venue, presence: true
  validates :status, inclusion: { in: statuses.keys }

  before_create :set_deadline

  after_create :set_booking_approvals

  after_update :send_mail, if: :status_changed?

  private

  def set_deadline
    deadline = DateTime.now + self.family.days_for_approval.days
    self.deadline = self.from < deadline ? self.from : deadline
  end

  def set_booking_approvals
    if self.family.days_for_approval.zero? || self.deadline == Date.current
      self.accepted!
    else
      self.family.users.each do |user|
        next if self.user_id == user.id
        BookingApproval.create(booking: self, user: user)
      end
    end
  end

  def send_mail
    BookingMailer.send_status(self).deliver_later
  end
end
