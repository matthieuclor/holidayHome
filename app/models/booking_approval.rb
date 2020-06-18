# frozen_string_literal: true

class BookingApproval < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  belongs_to :message, optional: true

  accepts_nested_attributes_for :message

  enum status: %i(pending accepted refused out_of_time)

  validates :booking, :user, :status, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates_uniqueness_of :user, scope: :booking

  after_create :send_mail

  private

  def send_mail
    BookingMailer.send_approval(self.booking, self.user).deliver_later
  end
end
