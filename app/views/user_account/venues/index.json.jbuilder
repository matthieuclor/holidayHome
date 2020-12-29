# frozen_string_literal: true

json.venues @venues do |venue|
  json.call(
    venue,
    :id,
    :name,
    :address,
    :beddings_count,
    :bedrooms_count,
    :bathrooms_count,
    :with_washing_machine,
    :with_tumble_dryer,
    :with_dishwasher,
    :with_network,
    :baby_beds_count,
  )

  if venue.photos.attached?
    json.first_photo_url url_for(
      venue.photos.first.variant(resize_to_limit: [300, 200])
    )
  end
end

json.pagy do
  json.prev @pagy.prev
  json.t_prev pagy_t('pagy.nav.prev')
  json.next @pagy.next
  json.t_next pagy_t('pagy.nav.next')
  json.series(@pagy.series { |item| json.item item })
end
