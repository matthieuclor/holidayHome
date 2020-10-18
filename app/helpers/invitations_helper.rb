# frozen_string_literal: true

module InvitationsHelper
  def invitation_status_badge(invitation)
    badge_class = case
      when invitation.pending? then 'secondary'
      when invitation.accepted? then 'success'
      when invitation.refused? then 'danger'
    end

    content_tag(
      :span,
      Invitation.human_attribute_name("status.#{invitation.status}"),
      class: ["badge badge-#{badge_class}"],
      data: { toggle: "tooltip" },
      title: Invitation.human_attribute_name("status_description.#{invitation.status}")
    )
  end

  def invitation_response_badge(invitation)
    return unless invitation.accepted? || invitation.refused?

    content_tag(
      :span,
      (invitation.accepted? ? 'Oui' : 'Non'),
      class: ["badge badge-#{invitation.accepted? ? 'success' : 'danger'}"]
    )
  end
end
