json.id @venue.id
json.name @venue.name
json.address @venue.address
json.beddings_count @venue.beddings_count
json.bedrooms_count @venue.bedrooms_count
json.bathrooms_count @venue.bathrooms_count
json.with_network @venue.with_network
json.baby_beddings_count @venue.baby_beddings_count
json.comment @venue.comment

if @venue.photos.attached?
  json.photos @venue.photos do |photo|
    json.url url_for(photo.variant(resize_to_limit: [550, 300]))
  end
end

if @venue.map.attached?
  json.map_url url_for(@venue.map.variant(resize_to_limit: [300, 300]))
end

json.bedrooms @venue.bedrooms do |bedroom|
  json.id bedroom.id
  json.name bedroom.name

  json.beddings bedroom.beddings do |bedding|
    json.id bedding.id
    json.bed_type Bedding.human_attribute_name("bed_type.#{bedding.bed_type}")
    json.bed_count bedding.bed_count
  end
end

json.bathrooms @venue.bathrooms do |bathroom|
  json.id bathroom.id
  json.name bathroom.name
end

json.keys @venue.keys do |key|
  json.id key.id
  json.name key.name
  json.owner key.owner, :id, :first_name, :last_name
end

json.networks @venue.networks do |network|
  json.id network.id
  json.name network.name
  json.password network.password
end

json.digital_codes @venue.digital_codes do |digital_code|
  json.id digital_code.id
  json.name digital_code.name
  json.password digital_code.password
end

json.home_services @venue.home_services do |home_service|
  json.id home_service.id
  json.name home_service.name
  json.person_in_charge home_service.person_in_charge
  json.phone home_service.phone
  json.email home_service.email
  json.address home_service.address
end

