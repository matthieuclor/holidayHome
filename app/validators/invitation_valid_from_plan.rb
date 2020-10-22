# frozen_string_literal: true

class InvitationValidFromPlan < ActiveModel::Validator
  def validate(invitation)
    return if invitation.family.users.any? { |user| user.premium? }
    return if invitation.sender.families.first == invitation.family &&
      invitation.family.invitations.count < User::PLAN_BASIC_LIMIT[:families_users]

    invitation.errors.add(:base, :plan_basic_limit)
  end
end
