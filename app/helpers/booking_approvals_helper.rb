# frozen_string_literal: true

module BookingApprovalsHelper
  def approval_icon(status)
    icon, color = case status
      when 'pending' then ['circle', 'text-secondary']
      when 'accepted' then ['check-circle', 'text-success']
      when 'refused' then ['times-circle', 'text-danger']
      when 'out_of_time' then ['clock', 'text-warning']
    end

    content_tag(
      :i,
      nil,
      class: ["far", "fa-#{icon}", color],
      data: { toggle: "tooltip" },
      title: BookingApproval.human_attribute_name("status.#{status}")
    )
  end
end
