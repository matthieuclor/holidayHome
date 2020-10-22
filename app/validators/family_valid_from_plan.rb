# frozen_string_literal: true

class FamilyValidFromPlan < ActiveModel::Validator
  def validate(family)
    return if family.creator.families.first.premium?
    return if family.creator.families.count < User::PLAN_BASIC_LIMIT[:families]

    family.errors.add(:base, :plan_basic_limit)
  end
end
