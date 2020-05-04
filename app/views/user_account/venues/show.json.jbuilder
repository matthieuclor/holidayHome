json.(@venue, :id,
  :name,
  :address,
  :beddings_count,
  :bedrooms_count,
  :bathrooms_count,
  :with_network,
  :baby_beddings_count,
  :comment
)

if @venue.photos.attached?
  json.photos @venue.photos do |photo|
    json.url url_for(photo.variant(resize_to_limit: [550, 300]))
  end
end

if @venue.map.attached?
  json.map_url url_for(@venue.map.variant(resize_to_limit: [300, 300]))
end

json.bedrooms @venue.bedrooms do |bedroom|
  json.(bedroom, :id, :name)

  json.beddings bedroom.beddings do |bedding|
    json.(bedding, :id, :bed_count)
    json.bed_type Bedding.human_attribute_name("bed_type.#{bedding.bed_type}")
  end
end

json.bathrooms @venue.bathrooms { |bathroom| json.(bathroom, :id, :name) }

json.keys @venue.keys do |key|
  json.(key, :id, :name)
  json.owner key.owner, :id, :first_name, :last_name
end

json.networks @venue.networks { |network| json.(network, :id, :name, :password) }

json.digital_codes @venue.digital_codes do |digital_code|
  json.(digital_code, :id, :name, :password)
end

json.home_services @venue.home_services do |home_service|
  json.(home_service, :id, :name, :person_in_charge, :phone, :email, :address)
end

