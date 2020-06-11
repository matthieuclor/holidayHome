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
    date_range = if booking.from == booking.to
      "Le #{I18n.l(booking.from, format: :medium)}"
    else

      "Du #{I18n.l(booking.from, format: :medium)}" +
      " au #{I18n.l(booking.to, format: :medium)}"
    end

    content_tag(:span, date_range)
  end

  def booking_progress_deadline(booking)
    days_left = (booking.deadline.to_date - Date.current).to_i
    days_left = days_left < 0 ? 0 : days_left
    days_for_approval = (booking.deadline.to_date - booking.created_at.to_date).to_i
    percentage = 100.0 - (days_left.to_f/days_for_approval.to_f * 100.0)

    title = if days_left.zero?
      "Terminé"
    else
      "#{days_left} #{'jour'.pluralize(days_left)} #{'restant'.pluralize(days_left)}"
    end

    content_tag(
      :div,
      content_tag(
        :div,
        nil,
        class: ["progress-bar", "#{'bg-success' if percentage >= 100}"],
        role: "progressbar",
        style: "width: #{percentage}%;",
        'aria-valuenow': "#{percentage}",
        'aria-valuemin': "0",
        'aria-valuemax': "100"
      ),
      class: "progress",
      data: { toggle: "tooltip" },
      title: title
    )
  end
end
