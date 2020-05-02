json.array! @venues do |venue|
  json.id venue.id
  json.name venue.name
  json.address venue.address
  json.beddings_count venue.beddings_count
  json.bedrooms_count venue.bedrooms_count
  json.bathrooms_count venue.bathrooms_count
  json.with_network venue.with_network
  json.baby_beddings_count venue.baby_beddings_count

  if venue.photos.attached?
    json.first_photo_url url_for(
      venue.photos.first.variant(resize_to_limit: [300, 200])
    )
  end
end
