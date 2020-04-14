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
end
