json.venues @venues do |venue|
  json.(venue, :id, :name)

  if venue.photos.attached?
    json.photo_url url_for(
      venue.photos.first.variant(resize_to_limit: [120, 60])
    )
  end
end

json.current_venue(@current_venue, :id, :name)

json.current_user(current_user, :id)

json.current_school_holiday_zones current_user.current_school_holiday_zones
