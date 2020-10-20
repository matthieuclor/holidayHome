# frozen_string_literal: true

module UsersHelper
  def user_avatar(user, format:[30, 30], avatar_class:"rounded-circle")
    if user.avatar.attached?
      image_tag(
        user.avatar.variant(resize_to_limit: format),
        class: "#{avatar_class}"
      )
    else
      content_tag(
        :span,
        content_tag(
          :span,
          "#{user.first_name[0].upcase}.#{user.last_name[0].upcase}",
          class: ["text-dark position-absolute"],
          style: [
            "top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: #{format[0]/3}px;"
          ]
        ),
        class: ["d-block bg-light #{avatar_class} position-relative"],
        style: ["width: #{format[0]}px; height: #{format[1]}px;"]
      )
    end
  end

  def user_confirmed_status(confirmed_status)
    fa_icon(
      confirmed_status ? "check" : "clock",
      nil,
      class: "text-#{confirmed_status ? 'success' : 'warning'}"
    )
  end

  def user_plan_badge(user)
    badge_class = case
      when user.basic? then 'secondary'
      when user.premium? then 'success'
    end

    content_tag(
      :span,
      User.human_attribute_name("plan.#{user.plan}"),
      class: ["badge badge-#{badge_class}"]
    )
  end

  def user_progress_deadline(user)
    content_tag(
      :div,
      content_tag(
        :div,
        nil,
        class: ["progress-bar", "#{'bg-success' if user.plan_progress_percentage >= 100}"],
        role: "progressbar",
        style: "width: #{user.plan_progress_percentage}%;",
        'aria-valuenow': "#{user.plan_progress_percentage}",
        'aria-valuemin': "0",
        'aria-valuemax': "100"
      ),
      class: "progress",
      data: { toggle: "tooltip" },
      title: user.plan_progress_title
    )
  end
end
