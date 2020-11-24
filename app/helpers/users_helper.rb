# frozen_string_literal: true

module UsersHelper
  def user_avatar(user, format: [30, 30], avatar_class: 'rounded-circle')
    if user.avatar.attached?
      image_tag(
        user.avatar.variant(resize_to_limit: format),
        class: avatar_class
      )
    else
      tag.span(
        tag.span(
          "#{user.first_name[0].upcase}.#{user.last_name[0].upcase}",
          class: %w(text-dark position-absolute),
          style: [
            'top: 50%;',
            'left: 50%;',
            'transform: translate(-50%, -50%);',
            "font-size: #{format[0] / 3}px;"
          ]
        ),
        class: ['d-block', 'bg-light', avatar_class, 'position-relative'],
        style: ["width: #{format[0]}px;", "height: #{format[1]}px;"]
      )
    end
  end

  def user_confirmed_status(confirmed_status)
    fa_icon(
      confirmed_status ? 'check' : 'clock',
      nil,
      class: "text-#{confirmed_status ? 'success' : 'warning'}"
    )
  end
end
