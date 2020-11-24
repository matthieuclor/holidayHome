# frozen_string_literal: true

module VenuesHelper
  def venue_photos(venue, format: [200, 100], avatar_class: 'rounded img-fluid')
    if venue.photos.attached?
      image_tag(
        venue.photos.first.variant(resize_to_limit: format),
        class: avatar_class
      )
    else
      tag.span(
        tag.span(
          fa_icon('home'),
          class: %w(text-muted position-absolute),
          style: [
            'top: 50%;',
            'left: 50%;',
            'transform: translate(-50%, -50%);',
            "font-size: #{format[1] / 2}px;"
          ]
        ),
        class: ['d-block', 'bg-light', avatar_class, 'position-relative'],
        style: ["width: #{format[0]}px;", "height: #{format[1]}px;"]
      )
    end
  end
end
