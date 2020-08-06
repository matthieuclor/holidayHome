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

  after_update :send_mail, if: :status_previously_changed?
  after_update :update_booking_approvals_status, if: :status_previously_changed?

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
    return if %w(pending canceled).include?(self.status)
    BookingMailer.send_status(self).deliver_later
  end

  def update_booking_approvals_status
    return if self.pending?
    self.booking_approvals.pending.update_all(status: :out_of_time)
  end
end
