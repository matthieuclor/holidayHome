class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable, :confirmable, :lockable

  has_one_attached :avatar

  has_many :family_links, dependent: :destroy
  has_many :families, through: :family_links
  has_many :sended_invitations, class_name: "Invitation", foreign_key: :sender_id
  has_many :received_invitations, class_name: "Invitation", foreign_key: :receiver_id
  has_many :invitees, through: :invitations, source: :receiver

  enum step: %i(account_created family_created venue_created)

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
