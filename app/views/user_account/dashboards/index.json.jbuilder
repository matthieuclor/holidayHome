json.venues @venues do |venue|
  json.id venue.id
  json.name venue.name

  if venue.photos.attached?
    json.photo_url url_for(
      venue.photos.first.variant(resize_to_limit: [200, 100])
    )
  end
end

json.current_venue_id @current_venue.id
