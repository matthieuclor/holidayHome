# frozen_string_literal: true

module BookingsHelper
  def booking_status_badge(status)
    badge_class = case status
      when 'pending' then 'secondary'
      when 'accepted' then 'success'
      when 'refused' then 'danger'
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
    percentage_left = 100.0 - (days_left.to_f/booking.family.days_for_approval.to_f * 100.0)
    title = "#{days_left} #{'jour'.pluralize(days_left)} #{'restant'.pluralize(days_left)}"

    content_tag(
      :div,
      content_tag(
        :div,
        number_to_percentage(percentage_left, precision: 0) ,
        class: "progress-bar",
        role: "progressbar",
        style: "width: #{percentage_left}%;",
        'aria-valuenow': "#{percentage_left}",
        'aria-valuemin': "0",
        'aria-valuemax': "100"
      ),
      class: "progress",
      data: { toggle: "tooltip" },
      title: title
    )
  end
end
