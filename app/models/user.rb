# frozen_string_literal: true

class User < ApplicationRecord
  PLAN_BASIC_LIMIT = {
    families: 1,
    families_users: 3,
    families_venues: 1,
    venues_photos: 1
  }

  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable, :confirmable, :lockable, :trackable

  has_one_attached :avatar, dependent: :destroy

  belongs_to :current_family, class_name: "Family", optional: true

  has_many :family_links, dependent: :destroy
  has_many :families, through: :family_links
  has_many :created_families, class_name: "Family"
  has_many :sended_invitations, class_name: "Invitation", foreign_key: :sender_id
  has_many :received_invitations, class_name: "Invitation", foreign_key: :receiver_id
  has_many :invitees, through: :invitations, source: :receiver
  has_many :venues, through: :families
  has_many :created_venues, class_name: "Venue", foreign_key: :creator_id
  has_many :keys, foreign_key: :owner_id
  has_many :bookings, dependent: :destroy
  has_many :booking_approvals, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy

  enum status: %i(activated deactivated blocked)
  enum plan: %i(basic premium)

  default_scope { where(status: :activated) }

  validates :avatar, content_type: [:png, :jpg, :jpeg],
                     size: { less_than: 2.megabytes }

  validates :first_name, :last_name, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :plan, inclusion: { in: plans.keys }
  validates_presence_of :plan_deadline, if: :premium?

  before_save -> { first_name.capitalize! }, if: :first_name_changed?
  before_save -> { last_name.capitalize! }, if: :last_name_changed?
  before_save -> { self.plan_deadline = nil if basic? }, if: :plan_changed?

  after_save :set_families_plan, if: :plan_previously_changed?

  def active_for_authentication?
    self.activated! if self.deactivated?
    super && self.activated?
  end

  def inactive_message
    self.activated? ? super : self.status.to_sym
  end

  def self.find_for_authentication(conditions)
    unscoped { super(conditions) }
  end

  private

  def set_families_plan
    if basic?
      ids = families.premium.reject { |f| f.premium_users.present? }.pluck(:id)
      Family.where(id: ids).update_all(plan: plan, plan_deadline: plan_deadline)
    else
      families.update_all(plan: plan, plan_deadline: plan_deadline)
    end
  end
end
