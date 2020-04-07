module InvitationsHelper

  def invitation_status_badge(status)
    badge_class = case status
      when "pending" then "secondary"
      when "awaiting_acceptance" then "primary"
      when "awaiting_creation" then "info"
      when "accepted" then "success"
      when "created" then "success"
    end

    content_tag(
      :span,
      Invitation.human_attribute_name("status.#{status}"),
      class: ["badge badge-#{badge_class}"],
      data: { toggle: "tooltip" },
      title: Invitation.human_attribute_name("status_description.#{status}")
    )
  end
end
