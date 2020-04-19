# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable, :confirmable, :lockable

  has_one_attached :avatar, dependent: :destroy

  has_many :family_links, dependent: :destroy
  has_many :families, through: :family_links
  has_many :sended_invitations, class_name: "Invitation", foreign_key: :sender_id
  has_many :received_invitations, class_name: "Invitation", foreign_key: :receiver_id
  has_many :invitees, through: :invitations, source: :receiver
  has_many :venues, through: :families
  has_many :created_venues, class_name: "Venue", foreign_key: :creator_id
  has_many :keys, foreign_key: :owner_id

  enum step: %i(account_created family_created venue_created)

  validates :first_name, :last_name, presence: true
end
