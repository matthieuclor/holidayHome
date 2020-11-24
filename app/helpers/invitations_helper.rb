# frozen_string_literal: true

module InvitationsHelper
  def invitation_status_badge(invitation)
    badge_class = {
      pending: 'secondary',
      accepted: 'success',
      refused: 'danger'
    }

    tag.span(
      Invitation.human_attribute_name("status.#{invitation.status}"),
      class: ["badge badge-#{badge_class[invitation.status.to_sym]}"],
      data: { toggle: 'tooltip' },
      title: Invitation.human_attribute_name("status_description.#{invitation.status}")
    )
  end

  def invitation_response_badge(invitation)
    return unless invitation.accepted? || invitation.refused?

    tag.span(
      (invitation.accepted? ? 'Oui' : 'Non'),
      class: ["badge badge-#{invitation.accepted? ? 'success' : 'danger'}"]
    )
  end
end
