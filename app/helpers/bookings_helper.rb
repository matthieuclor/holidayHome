# frozen_string_literal: true

module BookingsHelper
  def booking_status_badge(status)
    badge_class = {
      pending: 'secondary',
      accepted: 'success',
      refused: 'danger',
      canceled: 'warning'
    }

    tag.span(
      Booking.human_attribute_name("status.#{status}"),
      class: ["badge badge-#{badge_class[status.to_sym]}"]
    )
  end

  def booking_progress_deadline(booking)
    tag.div(
      tag.div(
        class: ['progress-bar', ('bg-success' if booking.progress_percentage >= 100)],
        role: 'progressbar',
        style: "width: #{booking.progress_percentage}%;",
        'aria-valuenow': booking.progress_percentage.to_s,
        'aria-valuemin': '0',
        'aria-valuemax': '100'
      ),
      class: 'progress',
      data: { toggle: 'tooltip' },
      title: booking.progress_title
    )
  end
end
