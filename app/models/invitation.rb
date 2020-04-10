class Invitation < ApplicationRecord
  LIMIT_OF_SEND = 3
  LIMIT_OF_SEND_DATE = 24.hours

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User", optional: true
  belongs_to :family

  default_scope { order(:created_at) }

  validates :email, presence: true

  validates_uniqueness_of :email, scope: [:family_id], conditions: -> {
    where.not(status: %w(accepted refused user_created))
  }

  validate :uniqueness_of_receiver_family, on: :create

  enum status: %i(
    pending
    awaiting_acceptance
    awaiting_user_creation
    accepted
    refused
    user_created
  )

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
