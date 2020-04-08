module InvitationsHelper

  def invitation_status_badge(status)
    badge_class, badge_status =
      if %w(pending awaiting_acceptance awaiting_creation).include?(status)
        ["secondary", "pending"]
      elsif %w(accepted created).include?(status)
        ["success", "accepted"]
      end

    content_tag(
      :span,
      Invitation.human_attribute_name("status.#{badge_status}"),
      class: ["badge badge-#{badge_class}"],
      data: { toggle: "tooltip" },
      title: Invitation.human_attribute_name("status_description.#{badge_status}")
    )
  end
end
