# frozen_string_literal: true

module VenuesHelper
  def venue_photos(venue, format:[200, 100], avatar_class:"rounded")
    if venue.photos.attached?
      image_tag(
        venue.photos.first.variant(resize_to_limit: format),
        class: "#{avatar_class}"
      )
    else
      content_tag(
        :span,
        content_tag(
          :span,
          fa_icon("home"),
          class: ["text-secondary position-absolute"],
          style: [
            "top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: #{format[0]/3}px;"
          ]
        ),
        class: ["d-block bg-light #{avatar_class} position-relative"],
        style: ["width: #{format[0]}px; height: #{format[1]}px;"]
      )
    end
  end
end
