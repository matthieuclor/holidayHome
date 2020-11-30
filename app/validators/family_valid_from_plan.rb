# frozen_string_literal: true

class FamilyValidFromPlan < ActiveModel::Validator
  def validate(family)
    families = [
      *Family.joins(:family_links)
             .where(family_links: { user_id: family.creator_id }),
      family
    ]

    return if families.first.premium?
    return if families.size <= User::PLAN_BASIC_LIMIT[:families]

    family.errors.add(:base, :plan_basic_limit)
  end
end
