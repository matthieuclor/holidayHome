module ApplicationHelper
  def fa_icon(icon, text = "", options = {})
    content_tag(
      :i,
      nil,
      class: [
        options[:prefix] || "fas",
        "fa-#{icon}",
        options[:class],
        "mr-2"
      ]
    ) + text
  end
end
