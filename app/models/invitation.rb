class Invitation < ApplicationRecord
  LIMIT_OF_SEND = 3
  LIMIT_OF_SEND_DATE = 24.hours

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User", optional: true
  belongs_to :family

  default_scope { order(:created_at) }

  validates :email, presence: true

  enum status: %i(pending awaiting_acceptance awaiting_creation accepted created)

  before_create :set_token
  after_create -> { SendInvitationEmail.call(invitation: self) }

  private

  def set_token
    self.token = Digest::SHA1.hexdigest([Time.now, self.email, rand].join)
  end
end
