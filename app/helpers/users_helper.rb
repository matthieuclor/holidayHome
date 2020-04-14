# frozen_string_literal: true

module UsersHelper
  def user_confirmed_status(confirmed_status)
    fa_icon(
      confirmed_status ? "check" : "clock",
      nil,
      class: "text-#{confirmed_status ? 'success' : 'warning'}"
    )
  end

  def user_avatar(user, format:[30, 30], avatar_class:"")
    if user.avatar.attached?
      image_tag(
        user.avatar.variant(resize_to_limit: format),
        class: "rounded-circle #{avatar_class}"
      )
    else
      content_tag(
        :span,
        "#{user.first_name[0].upcase}.#{user.last_name[0].upcase}",
        class: ["border border-secondary rounded-circle text-muted px-1 py-2"]
      )
    end
  end
end
