# frozen_string_literal: true

json.venues @venues do |venue|
  json.id venue.id
  json.name venue.name
  json.address venue.address
  json.beddings_count venue.beddings_count
  json.bedrooms_count venue.bedrooms_count
  json.bathrooms_count venue.bathrooms_count
  json.with_network venue.with_network
  json.baby_beds_count venue.baby_beds_count

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
