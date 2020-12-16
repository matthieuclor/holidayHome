# frozen_string_literal: true

module BookingApprovalsHelper
  def booking_approval_status_badge(status)
    badge_class = {
      pending: 'secondary',
      accepted: 'success',
      refused: 'danger',
      out_of_time: 'warning'
    }

    tag.span(
      BookingApproval.human_attribute_name("status.#{status}"),
      class: ["badge badge-#{badge_class[status.to_sym]}"]
    )
  end
end
