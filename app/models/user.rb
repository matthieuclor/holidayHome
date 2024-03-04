# frozen_string_literal: true

class User < ApplicationRecord
  PLAN_BASIC_LIMIT = {
    families: 1,
    families_users: 4,
    families_venues: 1,
    venues_photos: 1
  }.freeze

  # Include default devise modules. Others available are: :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :timeoutable, :confirmable, :lockable, :trackable

  has_one_attached :avatar

  belongs_to :current_family, class_name: 'Family', optional: true

  has_many :family_links, dependent: :destroy
  has_many :families, through: :family_links
  has_many :invitees, through: :invitations, source: :receiver
  has_many :venues, through: :families
  has_many :created_venues,
           class_name: 'Venue',
           foreign_key: :creator_id,
           inverse_of: :creator,
           dependent: :destroy

  has_many :keys, foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booking_approvals, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :sended_invitations,
           class_name: 'Invitation',
           foreign_key: :sender_id,
           dependent: :destroy,
           inverse_of: :sender

  has_many :received_invitations,
           class_name: 'Invitation',
           foreign_key: :receiver_id,
           dependent: :destroy,
           inverse_of: :receiver

  enum status: %i(activated deactivated blocked)
  enum plan: %i(basic premium)

  default_scope { where(status: :activated) }

  validates :avatar, content_type: %i(png jpg jpeg),
                     size: { less_than: 2.megabytes }

  validates :first_name, :last_name, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :plan, inclusion: { in: plans.keys }
  validates :plan_deadline, presence: { if: :premium? }
  validate :current_school_holiday_zones_presence_and_inclusion

  before_save -> { first_name.capitalize! }, if: :first_name_changed?
  before_save -> { last_name.capitalize! }, if: :last_name_changed?
  before_save -> { self.plan_deadline = nil if basic? }, if: :plan_changed?

  after_save :set_families_plan, if: :plan_previously_changed?

  def active_for_authentication?
    activated! if deactivated?
    super && activated?
  end

  def inactive_message
    activated? ? super : status.to_sym
  end

  def self.find_for_authentication(conditions)
    unscoped { super(conditions) }
  end

  def generate_jwt
    JWT.encode(
      { id:, exp: 24.hours.from_now.to_i },
      Rails.application.secret_key_base
    )
  end

  private

  def current_school_holiday_zones_presence_and_inclusion
    if current_school_holiday_zones.nil?
      errors.add(:current_school_holiday_zones, :presence)
      return
    end

    current_school_holiday_zones.keys == %w(A B C) ||
      errors.add(:current_school_holiday_zones, :inclusion)

    valid_values = ['true', 'false', true, false]

    return if current_school_holiday_zones.values.all? { |v| valid_values.include?(v) }

    errors.add(:current_school_holiday_zones, :inclusion)
  end

  def set_families_plan
    if basic?
      families.premium.includes(:premium_users).find_each do |family|
        if family.premium_users.present?
          family.update(plan_deadline: family.premium_users.maximum(:plan_deadline))
        else
          family.update(plan:, plan_deadline:)
        end
      end
    else
      families.includes(:creator).find_each do |family|
        family.update(
          plan:,
          plan_deadline: family.premium_users.maximum(:plan_deadline)
        )
      end
    end
  end
end
