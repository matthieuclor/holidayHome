# frozen_string_literal: true

class Family < ApplicationRecord
  MIN_DAYS_FOR_APPROVAL = 0
  MAX_DAYS_FOR_APPROVAL = 30

  belongs_to :creator, class_name: "User"

  has_many :family_links, dependent: :destroy
  has_many :users, through: :family_links
  has_many :invitations, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :bookings, through: :venues
  has_many :notifications, dependent: :destroy

  enum plan: %i(basic premium)

  default_scope { order(:created_at) }

  validates_with FamilyValidFromPlan, on: :create
  validates :name, :days_for_approval, presence: true
  validates :days_for_approval, inclusion: MIN_DAYS_FOR_APPROVAL..MAX_DAYS_FOR_APPROVAL
  validates :plan, inclusion: { in: plans.keys }
  validates_presence_of :plan_deadline, if: :premium?
end
