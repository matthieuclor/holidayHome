# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  has_one :family, through: :venue

  has_many :booking_approvals, dependent: :destroy
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :messages

  enum status: %i(pending accepted refused canceled)

  default_scope { order(:from) }

  validates_with BookingValidFromPlan, on: :create
  validates :from, :to, :user, :venue, presence: true
  validates :status, inclusion: { in: statuses.keys }

  before_create :set_deadline

  after_create_commit :set_booking_approvals

  after_update_commit :send_mail, if: :status_previously_changed?
  after_update_commit :update_booking_approvals_status, if: :status_previously_changed?

  private

  def set_deadline
    new_deadline = DateTime.now + self.family.days_for_approval.days
    self.deadline = from < new_deadline ? from : new_deadline
  end

  def set_booking_approvals
    if family.days_for_approval.zero? || deadline == Date.current
      accepted!
    else
      family.users.each do |user|
        next if user_id == user.id
        BookingApproval.create(booking: self, user: user)
      end
    end
  end

  def send_mail
    return if %w(pending canceled).include?(status)
    BookingMailer.send_status(self).deliver_later
    Notification.create(
      url: Rails.application.routes.url_helpers.user_account_booking_path(self),
      user: user,
      family: family,
      notification_type: "#{status}_booking".to_sym,
      description: Notification.human_attribute_name(
        "description.#{status}_booking",
        {
          venue: venue.name,
          dates: BookingDecorator.new(self).human_date_range
        }
      )
    )
  end

  def update_booking_approvals_status
    return if pending?
    booking_approvals.pending.update_all(status: :out_of_time)
  end
end
