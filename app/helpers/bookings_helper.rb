# frozen_string_literal: true

module BookingsHelper
  def booking_status_badge(status)
    badge_class = case status
      when 'pending' then 'secondary'
      when 'accepted' then 'success'
      when 'refused' then 'danger'
      when 'canceled' then 'warning'
    end

    content_tag(
      :span,
      Booking.human_attribute_name("status.#{status}"),
      class: ["badge badge-#{badge_class}"]
    )
  end

  def booking_date_range(booking)
    if booking.from == booking.to
      "Le #{I18n.l(booking.from, format: :medium)}"
    else
      "Du #{I18n.l(booking.from, format: :medium)}" +
      " au #{I18n.l(booking.to, format: :medium)}"
    end
  end

  def booking_progress_deadline(booking)
    content_tag(
      :div,
      content_tag(
        :div,
        nil,
        class: ["progress-bar", "#{'bg-success' if booking.progress_percentage >= 100}"],
        role: "progressbar",
        style: "width: #{booking.progress_percentage}%;",
        'aria-valuenow': "#{booking.progress_percentage}",
        'aria-valuemin': "0",
        'aria-valuemax': "100"
      ),
      class: "progress",
      data: { toggle: "tooltip" },
      title: booking.progress_title
    )
  end
end
