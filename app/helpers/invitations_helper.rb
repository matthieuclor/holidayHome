module InvitationsHelper
  def invitation_status_badge(invitation)
    badge_class, badge_status = case
      when invitation.is_available?
        ["secondary", "pending"]
      when invitation.is_not_available?
        invitation.response ? ["success", "accepted"] : ["danger", "refused"]
    end

    content_tag(
      :span,
      Invitation.human_attribute_name("status.#{badge_status}"),
      class: ["badge badge-#{badge_class}"],
      data: { toggle: "tooltip" },
      title: Invitation.human_attribute_name("status_description.#{badge_status}")
    )
  end

  def invitation_response_btn(invitation)
    return unless invitation.is_not_available?

    content_tag(
      :button,
      (invitation.response ? 'Oui' : 'Non'),
      class: ["btn btn-sm btn-#{invitation.response ? 'success' : 'danger'} px-4"],
      disabled: true
    )
  end
end
