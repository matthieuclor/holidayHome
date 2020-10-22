# frozen_string_literal: true

class FamilyValidFromPlan < ActiveModel::Validator
  def validate(family)
    return if family.creator.families.first.users.any? { |user| user.premium? }
    return if family.creator.families.count < User::PLAN_BASIC_LIMIT[:families]

    family.errors.add(:base, :plan_basic_limit)
  end
end
