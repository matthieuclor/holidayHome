# frozen_string_literal: true

class Invitation < ApplicationRecord
  LIMIT_OF_SEND = 3
  LIMIT_OF_SEND_DATE = 24.hours

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User", optional: true
  belongs_to :family

  default_scope { order(:created_at) }

  enum status: %i(pending accepted refused)

  validates :email, format: { with: Devise.email_regexp }, presence: true
  validates :sender, :family, :status, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validate :uniqueness_of_receiver_family, on: :create
  validates_uniqueness_of :email, scope: [:family_id], conditions: -> {
    where(status: 'pending')
  }

  before_validation :set_receiver
  before_create :set_token
  after_create_commit -> { SendInvitationEmail.call(invitation: self) }

  private

  def set_token
    self.token = Digest::SHA1.hexdigest([Time.now, self.email, rand].join)
  end

  def set_receiver
    self.receiver = User.find_by(email: self.email)
  end

  def uniqueness_of_receiver_family
    return unless self.receiver.present?

    if self.receiver.family_links.pluck(:family_id).include?(self.family_id)
      self.errors.add(:email, :exclusion)
    end
  end
end