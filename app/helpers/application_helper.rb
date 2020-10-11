# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def fa_icon(icon, text="", options={})
    content_tag(
      :i,
      nil,
      class: [
        options[:prefix] || "fas",
        "fa-#{icon}",
        options[:class]
      ]
    ) + text
  end

  def fa_check_icon(value, text)
    icon, color, prefix = if value.present?
      ['check-circle', 'text-success', 'fas']
    else
      ['circle', 'text-secondary', 'far']
    end

    fa_icon(icon, text, class: "mr-2 #{color}", prefix: prefix)
  end
end
