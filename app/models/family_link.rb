# frozen_string_literal: true

class FamilyLink < ApplicationRecord
  belongs_to :user
  belongs_to :family, inverse_of: :family_links
  belongs_to :premium_user,
             -> { where(plan: :premium) },
             inverse_of: :family_links,
             foreign_key: :user_id,
             class_name: 'User',
             optional: true

  validates :family, :user, presence: true
  validates :family, uniqueness: { scope: :user }

  after_create_commit :set_family_plan

  private

  def set_family_plan
    family.update(
      plan: family.premium_users.present? ? :premium : :basic,
      plan_deadline: family.premium_users.maximum(:plan_deadline)
    )
  end
end
